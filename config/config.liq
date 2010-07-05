#
# This file is part of radio-schlag
# Liquid soap configuration
#

# stream server
stream_host = "127.0.0.1"
stream_port = 8000

# icecast server auth info
src_passwd = "hackme"
src_login_ogg = "source"
src_login_mp3 = "source"

# where to output logs
log_path = "log/radio.log"

#######################################################
# Apply global settings
###


set("log.file.path", log_path)
set("log.stdout",true)
set("log.level", 4)

set("harbor.bind_addr","0.0.0.0")
set("harbor.port",12345)
set("harbor.password","K7gxYN4sD9Cmf6p2MV2bFf2KvaBEccFw")

set("server.telnet", true)
set("server.socket", true)
set("server.socket.path", "./<script>.sock")

