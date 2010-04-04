##
## playlist_maker_order.rb
## Login : <elthariel@rincevent>
## Started on  Mon Mar 29 15:21:51 2010 elthariel
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

class OrderPlaylistMaker
  def initialize
  end

  def make(active_record_playlist_object, pool, seconds)
    length = 0
    pls = Array.new

    pool.files.each do |f|
      if length < seconds
        pls.push f[0]
        length += f[0].duration
      end
    end

    Playlist.new(pls, length)

  end

end

end
