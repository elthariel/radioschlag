
output.icecast.vorbis(
  host = stream_host,
  port = stream_port,
  user = src_login_ogg,
  password = src_passwd,
  mount = "radio-schlag.ogg",
  genre = "FreeTekno",
  description = "Radio Schlag | FreeTekno Culture",
  url="http://radio.schlag.fr",
  quality = 4.,
  radio)

# Mp3 output for mac and flash player :( and for android player :)
#output.icecast.mp3(
#   host = stream_host,
#    port = stream_port,
#    user = src_login_mp3,
#    password = src_passwd,
#    mount = "radio-schlag.mp3",
#    genre = "FreeTekno",
#    description = "Radio Schlag | FreeTekno Culture",
#    url="http://radio.schlag.fr",
#    bitrate = 128,
#    radio)

# output.icecast.mp3(
#    host = stream_host,
#    port = stream_port,
#    user = src_login_mp3,
#    password = src_passwd,
#    mount = "radio-schlag-low.mp3",
#    genre = "FreeTekno",
#    description = "Radio Schlag | FreeTekno Culture",
#    url="http://radio.schlag.fr",
#    bitrate = 64,
#    radio)

