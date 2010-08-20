module AudioFilesHelper
  def audiofile_pretty_printer(file)
    e = file.path.split('/')
    # FIXME do something pretty
    #e[e.length - 2] + e[e.length - 1]
    e[e.length - 1]
  end

  def audio_tag(file, minimalist = false)
    url = url_for file

    tag = "<div class=\"af_player_box\">"
    tag += "<audio src=\"#{url}\" controls=\"true\" preload=none class=\"af_player\">"
    tag += "Your browser does not support the audio element. "
    tag += "Install a recent Firefox or Chromium version"
    tag += " </audio>"
    tag += "</div>"
    tag
  end
end
