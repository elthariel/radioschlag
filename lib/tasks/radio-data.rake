require 'find'

namespace :radio do
  desc "Scan all the data folder for new files"
  task :scan => :environment do
    root = RADIO_CONFIG[:audio_root]
    p "Radio data root dir: #{root}"

    Dir.open(root).each do |type|
      if (File.directory?("#{root}/#{type}") and type != '.' and type != '..')
        # Now browsing the type
        Dir.open("#{root}/#{type}").each do |style|
          if (File.directory?("#{root}/#{type}/#{style}") and style != '.' and style != '..')

            # Now browsing the styles folder of each type
            Find.find("#{root}/#{type}/#{style}") do |path|
              if (path =~ /\.(ogg|mp3)\Z/ and not (path =~ /\.tmp\.ogg\Z/))
#              if (path =~ /\.(ogg|mp3)\Z/)
                # Now we have all the file with their types and styles
                if File.readable? path
                  _add_file_to_db(type, style, path)
                end
              end
            end
          end
        end
      end
    end
  end

  desc "Reset to 1.0 all the audiofiles metric colum"
  task :reset_metric => :environment do
    tracks = AudioFile.all
    tracks.each do |f|
      f.metric = 1.0
      f.save
    end
  end

end

def _add_file_to_db(type, style, path)
  raise "This file type #{type} doesn't exists" unless AudioFileType.exists?(:name => type)
  return if AudioFile.exists?(:path => path)
  return if IncomingAudioFile.exists?(:path => path)
  AudioFileStyle.create(:name => style) unless AudioFileStyle.exists?(:name => style)

  type_id = AudioFileType.find_by_name(type).id
  style_id = AudioFileStyle.find_by_name(style).id
  owner_id = User.find_by_username(RADIO_CONFIG[:root]).id

  p "Adding a file to incoming audio files: #{type}:#{style}:#{path}"
  IncomingAudioFile.create(:path => path, :audio_file_style_id => style_id, :audio_file_type_id => type_id, :user_id => owner_id)
end
