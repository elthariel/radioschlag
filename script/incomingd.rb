#! /usr/bin/env runner
## incomingd.rb
## Login : <opp2@opp2-devsrv>
## Started on  Thu Dec  3 14:26:37 2009 opp2
## $Id$
##
## Author(s):
##  - opp2 <>
##
## Copyright (C) 2009 opp2
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##

require "#{RAILS_ROOT}/lib/sox/audio_file"
require 'logger'

$log = Logger.new("#{RAILS_ROOT}/log/incomingd.log")
#$log = Logger.new(STDOUT)
#$log.level = Logger::INFO


while (42)
  while (file = IncomingAudioFile.first)

    file.destroy
    infos = Sox::AudioFile.parse(file.path)
    new_path = file.path
    low = false

    # If infos != nil, this is a know audio file
    if infos
      if !(file.path =~ /___rs\.ogg\Z/)

        # Building sox conversion command line, using config options in config/radio_config.yml
        cmd =  "nice -n #{RADIO_CONFIG[:sox_nice]} "
        cmd += "#{RADIO_CONFIG[:sox]} "
        cmd += "--norm "
        cmd += "\"#{file.path}\" "
        cmd += "#{RADIO_CONFIG[:sox_format]} "
        cmd += "\"#{file.path}.tmp.ogg\" "
        cmd += "#{RADIO_CONFIG[:sox_fx]} "

        # If low quality, add some stereo and a very small reverb
        if (infos.infos[:bitrate] < 100 or infos.infos[:chans] == 1 or infos.infos[:rate] < 44000)
          low = true
          cmd += "2>&1"
        end

        # Executing the build command line
        $log.info "Launching conversion for incoming file (low:#{low}): #{file.path}"
        cmd_res = `#{cmd}`
        $log.warn "#{cmd_res}"

        # Computing the new path
        new_path = file.path.sub(/\.[\w]+\Z/, '.ogg')
        `rm "#{file.path}"`
        `mv "#{file.path}.tmp.ogg" "#{new_path}"`
      end

      AudioFile.create(:path => new_path, :duration => infos.infos[:duration],
                       :audio_file_style_id => file.audio_file_style_id,
                       :audio_file_type_id => file.audio_file_type_id,
                       :metric => 1.0, :user_id => file.user_id)

    else
      $log.warn "File doesn't seems to be an audio file: #{file.path}"
    end
  end

  sleep 10
end

