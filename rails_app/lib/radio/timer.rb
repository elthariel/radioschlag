##
## timer.rb
## Login : <opp2@opp2-devsrv>
## Started on  Tue Jan  5 23:05:07 2010 opp2
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

require 'radio/slot'

module Radio

class Timer
  attr_reader :seconds, :minutes, :hours, :days, :weeks

  def initialize
    @running = true
    @current_tick = Time.now
    @last_tick = Time.now

    @seconds = Slot.new
    @minutes = Slot.new
    @hours = Slot.new

    # Unimplemented
    @days  = Slot.new
    @weeks = Slot.new
  end

  def run
    @last_tick = Time.now

    while @running

      # Sleeping approximatively 1 seconds. Unreliable
      sleep 1

      @current_tick = Time.now

      # Checking how many seconds we slept.
      (@current_tick.to_i - @last_tick.to_i).times do
        @seconds.emit

        if @current_tick.to_i % 60 == 0
          @minutes.emit
        end

        if @current_tick.to_i % 3600 == 0
          @hours.emit
        end

      end

      @last_tick = @current_tick
    end
  end

  def running=(value)
    @running = value
  end

  def running
    @running
  end

  def self.time_to_week_minutes(atime)
    day = (atime.wday - 1) % 7
    day * 60 * 24 + atime.hour * 60 + atime.min
  end

  def self.now
    self.time_to_week_minutes(Time.now)
  end

end

end

