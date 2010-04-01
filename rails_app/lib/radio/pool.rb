##
## pool.rb
## Login : <elthariel@rincevent>
## Started on  Sun Mar 28 23:14:38 2010 elthariel
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

require 'radio/pool_maker_audiofile'

module Radio

class Pool
  attr_reader :files

  def initialize(files)
    # An array of active record AudioFile objects
    @files = files
  end
end

class PoolFactory
  def initialize
  end

  def make(active_record_playlist_object)
    pls = active_record_playlist_object

    begin
      maker_name = pls.playlist_type.name.capitalize + 'PoolMaker'
      strategy = Kernel.const_get(maker_name).new
    rescue
      strategy = AudiofilePoolMaker.new
    end

    begin
      pool = strategy.make(pls)
    rescue
      pool = Pool.new(Array.new)
    end

    pool
  end
end


end
