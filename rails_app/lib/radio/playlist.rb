##
## playlist.rb
## Login : <elthariel@rincevent>
## Started on  Mon Mar 29 14:20:34 2010 elthariel
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

require 'radio/playlist_maker_order'

module Radio

class Playlist
  attr_reader :files, :length

  def initialize(files, length)
    # An array of active record AudioFile objects
    # to be played by the scheduler
    @files = files
    @length = length
  end
end

class PlaylistFactory
  def initialize
    @pool_factory = PoolFactory.new
  end

  def make(active_record_playlist_object, seconds)
    pls_db = active_record_playlist_object
    pool = @pool_factory.make(pls_db)

    begin
      maker_name = pls.playlist_player.name.capitalize + 'PlaylistMaker'
      strategy = Kernel.const_get(maker_name).new
    rescue
      strategy = OrderPlaylistMaker.new
    end

    strategy.make(pls_db, pool, seconds)
  end
end

end
