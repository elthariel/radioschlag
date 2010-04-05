##
## scheduler.rb
## Login : <elthariel@rincevent>
## Started on  Mon Mar 29 16:53:45 2010 elthariel
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

require 'radio/playlist'

module Radio

# A schedulable element, aka slot + playlist
class Task
  attr_reader :slot, :playlist
  def initialize(slot, pls)
    @slot = slot
    @playlist = pls
  end
end

class Scheduler
  def initialize(liq)
    @liq = liq
    @playlist_factory = PlaylistFactory.new

    # The next playlist at the construction is the playlist that should be played now.
    now = Timer.now
    slot = ::Slot.find(:first, :conditions => ['start <= ? AND end > ?', now, now])
    @next = Task.new(slot, get_playlist_from_slot(slot))
  end

  def tick
    schedule_new_slot = false

    if (@next.slot.start == 0 and 10080 - Timer.now <= SCHEDULER_CONFIG[:playlist_lookahead]) or @next.slot.start - Timer.now <= SCHEDULER_CONFIG[:playlist_lookahead]
      schedule_new_slot = true
    end

    if schedule_new_slot
      puts "Scheduler: Generating a new playlist, for slot #{@next.slot.name}"
      effective_playlist = generate_playlist(@next)
      puts "Scheduler: The effective length of the playlist is #{effective_playlist.length / 60.0} minutes"
      output_playlist effective_playlist
      @next = next_task
    end

    # At the end of every slot, we double kick (to be sure,
    # and because it's funny) client connected to harbor live input.
    if Timer.now == @next.slot.start - 1 or Timer.now == @next.slot.start - 2
      puts "Scheduler: Kick harbor live source"
      @liq.send(SCHEDULER_CONFIG[:liq_live]).kick
    end

    # Return true or else or callback won't be called again
    true
  end

  def generate_playlist(task)
    length = @next.slot.end - @next.slot.start
    if Timer.now > @next.slot.start
      length -= Timer.now - @next.slot.start
    end
    puts "Scheduler: New playlist is #{length} minutes long"
    @playlist_factory.make(@next.playlist, length * 60)
  end

  def output_playlist(pls)
    ## Use a logger, and log this
    queue = @liq.send(SCHEDULER_CONFIG[:liq_queue])
    pls.files.each do |audiofile|
        # When debugging playlist generation
        #puts "#{audiofile.path}"
        queue.push "#{audiofile.path}"
      end
  end

  def default_playlist
    if defined? @default_playlist
      @default_playlist
    else
      ::Playlist.first
    end
  end

  def default_playlist=(new_default_playlist)
      @default_playlist = new_default_playlist
  end



  def next_task
    # 10080 minutes is the length in minutes of a week
    # We are wrapping the end of the week here.
    slot = ::Slot.first(:conditions => {:start => @next.slot.end % 10080})
    pls = get_playlist_from_slot(slot)
    Task.new(slot, pls)
  end

  protected
  def get_playlist_from_slot(slot)
    # FIXME Implement something better than just picking the first playlist
    begin
      slot.program.playlists.first
    rescue
      default_playlist
    end
  end
end

end
