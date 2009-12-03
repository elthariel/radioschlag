#! /usr/bin/ruby
## audio_file.rb
## Login : <opp2@opp2-devsrv>
## Started on  Tue Dec  1 23:32:27 2009 opp2
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

module Sox

  class AudioFile
    attr_reader :infos

    def self.parse(path)
      begin
        f = AudioFile.new(path)
        f
      rescue
        puts $!
        nil
      end
    end

    protected
    def initialize(path)
      @infos = Hash.new

       if (!File.readable?(path))
         raise "Not a file"
       end

      @infos[:path] = File.expand_path(path)

      if (`soxi '#{@infos[:path]}' 2>&1` =~ /soxi FAIL/)
        raise "Not an audio file"
      end

      @infos[:type] = `soxi -t '#{@infos[:path]}'`.chomp
      @infos[:rate] = `soxi -r '#{@infos[:path]}'`.chomp.to_i
      @infos[:chans] = `soxi -c '#{@infos[:path]}'`.chomp.to_i
      @infos[:duration] = `soxi -D '#{@infos[:path]}'`.chomp.to_i
      @infos[:bitrate] = `soxi -B '#{@infos[:path]}'`.chomp.to_i

      `soxi -a '#{@infos[:path]}'`.each do |l|
        duple = l.split('=')
        if duple[0] and duple[1]
          @infos[duple[0].downcase] = duple[1].chomp
        end
      end

    end


  end
end

if ($0 == __FILE__)
  f = Sox::AudioFile.parse(ARGV[0])
  f.infos.each {|k, v| p "#{k}=#{v}"}
end

