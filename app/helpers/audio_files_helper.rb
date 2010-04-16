module AudioFilesHelper
  def audiofile_pretty_printer(file)
    e = file.path.split('/')
    # FIXME do something pretty
    #e[e.length - 2] + e[e.length - 1]
    e[e.length - 1]
  end

  def audio_tag(file, minimalist = false)
    if file.path.index RADIO_CONFIG[:audio_root]
      folder = RADIO_CONFIG[:audio_root].split('/')[-1]
      fpath = file.path.sub(RADIO_CONFIG[:audio_root], '')
    elsif file.path.index RADIO_CONFIG[:ftp_root]
      folder = RADIO_CONFIG[:ftp_root].split('/')[-1]
      fpath = file.path.sub(RADIO_CONFIG[:ftp_root], '')
    else
      return 'Not playable'
    end

    url = RADIO_CONFIG[:http_listen]
    url += '/' + folder + fpath
    tag = "<audio src=\"#{url}\" controls=\"true\" preload=none>"
    tag += "Your browser does not support the audio element. "
    tag += "Install a recent Firefox or Chromium version"
    tag += " </audio>"
    tag
  end
end
