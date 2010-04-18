#! /usr/local/bin/liquidsoap -v

%include "config/config.liq"


def liveauth(login, password) =
  # Call an external process to check
  # the credentials:
  # The script will return the string
  # "true" of "false"
  #
  # First call the script
  ret = get_process_lines("./script/runner -eproduction ./script/harbor-auth #{quote(login)} #{quote(password)}")
  # Then get the first line of its output
  ret = list.hd(ret)
  # Finally returns the boolean represented
  # by the output
  bool_of_string(ret)
end


hinput = input.harbor(id = "live",
                      auth = liveauth,
                      "live")

radio = fallback(track_sensitive = false,
                 [hinput,
                  request.equeue(id = "rq"),
                  saw()])

# Stream it out
output.icecast.vorbis(
  host = stream_host,
  port = stream_port,
  user = src_login_ogg,
  password = src_passwd,
  mount = "radio-schlag.ogg",
  genre = "FreeTekno",
  description = "Radio Schlag | FreeTekno Culture",
  url="http://radio.schlag.fr",
  quality = 3.,
  radio)

# Mp3 output for mac and flash player :(
output.icecast.mp3(
   host = stream_host,
   port = stream_port,
   user = src_login_mp3,
   password = src_passwd,
   mount = "radio-schlag.mp3",
   genre = "FreeTekno",
   description = "Radio Schlag | FreeTekno Culture",
   url="http://radio.schlag.fr",
   bitrate = 96,
   radio)


