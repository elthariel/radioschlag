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
    slot = ::Slot.find(:first, :conditions => ['slots.start <= ? AND slots.end > ?', now, now])
    @next = Task.new(slot, get_playlist_from_slot(slot))
  end

  def tick
    manage_playlist_generation
    manage_playlist_feeding
    manage_live

    # Return true or else or callback won't be called again
    true
  end

  # We are here working around a limitation of liquidsoap queues.
  # There is a globally limited number (100) of request in queues.
  def manage_playlist_feeding
    in_queue = @liq.send(SCHEDULER_CONFIG[:liq_queue].to_s).pending_length[0].to_i
    if @current_playlist.files.length > 0 and in_queue < 15
      (15 - in_queue).times do
          if @current_playlist.files.length > 0
            @liq.send(SCHEDULER_CONFIG[:liq_queue].to_s).push @current_playlist.files.shift.path
          end
        end
    end
  end

  def manage_playlist_generation
    if (@next.slot.start == 0 and 10080 - Timer.now <= SCHEDULER_CONFIG[:playlist_lookahead]) or @next.slot.start - Timer.now <= SCHEDULER_CONFIG[:playlist_lookahead]
      $log.info "Scheduler: Generating a new playlist, for slot #{@next.slot.name}"
      @current_playlist = generate_playlist(@next)
      $log.info "Scheduler: The effective length of the playlist is #{@current_playlist.length / 60.0} minutes"
      @next = next_task
    end
  end

  def manage_live
    # At the end of every slot, we double kick (to be sure,
    # and because it's funny) client connected to harbor live input.
    if Timer.now == @next.slot.start - 1 or Timer.now == @next.slot.start - 2
      $log.info "Scheduler: Kick harbor live source"
      @liq.send(SCHEDULER_CONFIG[:liq_live]).kick
    end
  end

  def generate_playlist(task)
    length = @next.slot.end - @next.slot.start
    if Timer.now > @next.slot.start and Timer.now < @next.slot.end
      length -= Timer.now - @next.slot.start
    end
    $log.info "Scheduler: New playlist is #{length} minutes long"
    @playlist_factory.make(@next.playlist, length * 60)
  end

  def output_playlist(pls)
    ## Use a logger, and log this
    queue = @liq.send(SCHEDULER_CONFIG[:liq_queue])
    pls.files.each do |audiofile|
        # When debugging playlist generation
        $log.debug "#{audiofile.path}"
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
      slot.program.playlist
    rescue
      default_playlist
    end
  end
end

end
