##
## pool_maker_typestyle.rb
## Login : <elthariel@rincevent>
## Started on  Sat Apr  3 01:30:16 2010 elthariel
## $Id$
##
## Author(s):
##  - elthariel <elthariel@gmail.com>
##
## Copyright (C) 2010 elthariel
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

module Radio

class TypestylePoolMaker
  def initialize
  end

  def make(active_record_playlist_object)
    pls = active_record_playlist_object
    pool = Array.new

    puts "TypestylePoolMaker: Generating a new pool"

    # Refer to doc/METRIC for so explanation of the use of the metric
    pls.type_style_assignments.each do |ts|
        files = AudioFile.all(:conditions => {:audio_file_type_id => ts.audio_file_type_id,
                                :audio_file_style_id => ts.audio_file_style_id})
#        if (files.length > 0)
          metric_coef = ts.metric / file.length
          files.each { |f| pool.push [f, (1.0 / f.metric) * ts.metric] }
#        end
      end

    Pool.new(pool)
  end
end

end
