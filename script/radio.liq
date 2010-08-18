#! /usr/bin/env liquidsoap

%include "config/config.liq"
#%include "utils.liq"


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

def my_crossfade(x, a, b)
    add(normalize=false,
        [sequence([blank(duration=x),
                   fade.initial(duration=x * 2., b)]),
         fade.final(duration=x * 2., a) ])
end


hinput = input.harbor(id = "live",
                      auth = liveauth,
                      "live")

radio = fallback(track_sensitive = false,
                 transitions = [my_crossfade(0.75), my_crossfade(0.75)],
                 [hinput,
                  request.equeue(id = "jingles"),
                  request.equeue(id = "rq"),
                  blank()])

# Stream it out
%include "config/outputs.liq"
