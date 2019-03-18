require 'byebug'
require 'logger'

logger = Logger.new STDOUT

current_https_host = 'https://acceed35.ngrok.io' 
default_token = '1234AAAABBBBCCCCCDDDDEEEEEFFFF'
short_mp3 = '1_a_15.mp3'
long_mp3 = 'barbara.mp3'
extra_sort_mp3_url = 'https://s3.amazonaws.com/my-ssml-samples/Flourish.mp3'
start_offset = 0_000
# start_offset = 0

intent 'son_du_jour' do
  token = request.user_access_token || default_token
  audio_player.play(
    "#{current_https_host}/#{short_mp3}",
    token,
    offset_in_milliseconds: start_offset
  ).to_json
end

# intent 'son_du_jour' do
#   token = request.user_access_token || default_token
#   # logger.info('------------------------')
#   # logger.info(request.request['context']['AudioPlayer'])
#   # logger.info('-------------- End of daily sound ----------')
#   audio_player.play(
#     "#{current_https_host}/#{short_mp3}",
#     # "#{current_https_host}/#{long_mp3}",
#     # extra_sort_mp3_url,
#     token,
#     # behaviour: Ralyxa::ResponseEntities::Directives::AudioPlayer::Play::CLEAR_ENQUEUE,
#     offset_in_milliseconds: start_offset
#     # speech: 'Voici le son du jour',
#   ).tap do |response|
#     logger.debug(response)
#   end.to_json
# end
