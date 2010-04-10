# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # The official radio-sclag time pretty printer
  def seconds_to_string(s)
    h = s / 3600
    s %= 3600
    m = s / 60
    s %= 60

    if (h >= 1)
      "#{h}:#{sprintf('%.2d', m)}:#{sprintf('%.2d', s)}"
    else
      "#{m}:#{sprintf('%.2d', s)}"
    end
  end

  def files_to_sort
    if current_user
      AudioFile.all(:conditions => {:audio_file_style_id => 1,
                    :audio_file_type_id => 1}).length
    end
  end
end
