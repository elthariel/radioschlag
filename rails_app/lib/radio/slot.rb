##
## slot.rb
## Login : <opp2@opp2-devsrv>
## Started on  Mon Jan 11 13:26:35 2010 opp2
## $Id$
##
## Author(s):
##  - opp2 <>
##
## Copyright (C) 2010 opp2
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

class Slot
  def initialize
    @signals = Array.new
  end

  # A signal that returns false is removed from the signal list
  def emit(*args)
    @signals.each do |s|
      if !s.call(args)
        @signals.delete(s)
      end
    end
  end

  def connect(proc)
    @signals.push(proc)
  end
end

