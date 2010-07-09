module AudioFilesHelper
  def audiofile_pretty_printer(file)
    e = file.path.split('/')
    # FIXME do something pretty
    #e[e.length - 2] + e[e.length - 1]
    e[e.length - 1]
  end

  def audio_tag(file, minimalist = false)
    url = url_for file

    tag = "<audio src=\"#{url}\" controls=\"true\" preload=none>"
    tag += "Your browser does not support the audio element. "
    tag += "Install a recent Firefox or Chromium version"
    tag += " </audio>"
    tag
  end
end
