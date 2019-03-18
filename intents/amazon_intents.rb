require 'byebug'
require 'logger'

error_count = 0
logger = Logger.new STDOUT
session_end_response = {
  version: '1.0',
  response: {
    shouldEndSession: true
  }
}.to_json

intent 'menu' do
  ask 'Whesh ou whesh ?'
end

intent 'SessionEndedRequest' do
  tell('Bye Bye')
end

intent 'LaunchRequest' do
  message = "<audio src='soundbank://soundlibrary/home/amzn_sfx_door_open_01'/>" \
            'Bonjour! Que voulez-vous écouter ?'
            # "<audio src='soundbank://soundlibrary/foley/amzn_sfx_kitchen_ambience_01'/>" \
            # "<audio src='soundbank://soundlibrary/magic/amzn_sfx_fairy_melodic_chimes_01'/>" \
  intonation_message = "<speak>#{message}</speak>"
  ask(intonation_message, ssml: true).to_json
end

intent 'setting_settings' do
  # logger.debug Ralyxa::RequestEntities.Request.request.slot_value('time')
  time = request.slot_value('time')
  logger.debug time
  tell("Ce sera fait à #{time}")
end

intent 'AMAZON.StopIntent' do
  # audio_player.stop
  tell('Bye Bye !')
end

intent 'AMAZON.ClearQueue' do
  # audio_player.clear_queue
  ask 'Voulez-vous écouter autre chose ? ', start_over: true
end

intent 'AudioPlayer.PlaybackStarted' do
  logger.debug('Playback starts here ...')
  logger.debug(
    'offsetInMilliseconds : ' \
    "#{request.request['request']['offsetInMilliseconds']}"
  )
  session_end_response
end

intent 'AudioPlayer.PlaybackStopped' do
  logger.debug('PlaybackStopped: interruption with a bi-tone')
  logger.debug(
    'offsetInMilliseconds : ' \
    "#{request.request['request']['offsetInMilliseconds']}"
  )
  session_end_response
end

intent 'AMAZON.PauseIntent' do
  logger.debug('Pause intent fired')
end

intent 'AMAZON.StartOverIntent' do
  logger.debug('Alexa start over intent fired')
  tell('On recommence.', start_over: true)
end

intent 'AudioPlayer.PlaybackNearlyFinished' do
  logger.debug('Time to add up another playback from the list')
  session_end_response
end

intent 'AMAZON.PreviousIntent' do
  logger.debug('PreviousIntent fired')
end

intent 'AudioPlayer.PlaybackFinished' do
  error_count = 0
  logger.debug('PlaybackFinished intent fired')
  (JSON.parse audio_player.stop).tap do |response|
    response['response']['shouldEndSession'] = true
  end.to_json
end

intent 'AudioPlayer.PlaybackFailed' do
  logger.debug('AudioPlayer.PlaybackFailed intent fired')
  (JSON.parse audio_player.stop).tap do |response|
    response['response']['shouldEndSession'] = true
  end.to_json
  # tell('Nous sommes au regret de ne pas pouvoir jouer ce podcast')
end

intent 'System.ExceptionEncountered' do
  error_count += 1
  failure_details = request.request['request']
  error_details = failure_details['error']
  # logger.debug('Hello ExceptionEncountered!')
  # # logger.debug(request.request['context'])
  # logger.debug('----------------')
  # logger.debug("Error type : #{failure_details['type']}")
  # logger.debug("Error requestId : #{failure_details['requestId']}")
  logger.debug("Error timestamp : #{failure_details['timestamp']}")
  # logger.error("Error details (type) : #{error_details['type']}")
  logger.error('Error details (message) : ' \
               "##{error_count} - #{error_details['message']}")
  # logger.error("Error cause (requestId) : " \
  #              "#{failure_details['cause']['requestId']}")
  # logger.debug('==============================')
end
