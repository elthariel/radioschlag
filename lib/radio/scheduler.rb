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

require 'ruby-debug'

module Radio

# A schedulable element, aka slot + playlist
class Task
  attr_reader :slot, :playlist, :overrun
  def initialize(slot, pls, overrun)
    @slot = slot
    @playlist = pls
    # The overrun of the last playlist. This is to be subtracted from
    # the total length of the playlist to be generated (in minutes)
    @overrun = overrun
  end
end

class Scheduler
  def initialize(liq)
    @liq = liq
    @last_jingle = Timer.now
    @playlist_factory = PlaylistFactory.new

    # The next playlist at the construction is the playlist that should be played now.
    now = Timer.now
    slot = ::Slot.find(:first, :conditions => ['slots.start <= ? AND slots.end > ?', now, now])
    @next = Task.new(slot, get_playlist_from_slot(slot), 0)
    manage_playlist_generation(true)
  end

  def tick
    manage_playlist_generation
    manage_playlist_feeding
    manage_jingle
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

  def time_to_generate_playlist?
    # A special case when we are wrapping around the week
    week_wrap = (@next.slot.start == 0 and (10080 - Timer.now) <= SCHEDULER_CONFIG[:playlist_lookahead])

    # The normal case, we are just taking care of week wrapping, when
    # Timer.now is in the current week and next.slot is for the next
    # week (diff <= 0)
    diff = @next.slot.start - Timer.now
    normal = (@next.slot.start != 0 and diff >= 0 and diff <= SCHEDULER_CONFIG[:playlist_lookahead])

    #debugger

    week_wrap or normal
  end

  def manage_playlist_generation(first = false)
    if time_to_generate_playlist? or first
      $log.info "Scheduler: Generating a new playlist, for slot #{@next.slot.name}"
      overrun = generate_playlist(@next)
      @next = next_task(overrun)
    else
      # $log.debug "Not generating playlist"
    end
  end

  def manage_live
    # At the end of every slot, we double kick (to be sure,
    # and because it's funny) client connected to harbor live input.
    if Timer.now == @next.slot.start - 1 or Timer.now == @next.slot.start - 2
      $log.info "Scheduler: Kick harbor live source"
      @liq.send(SCHEDULER_CONFIG[:liq_live].to_s).kick
    end
  end

  def manage_jingle
    if Timer.now - @last_jingle >= SCHEDULER_CONFIG[:jingle_interval]
      jingles = AudioFile.all(:conditions => ["audio_file_type_id = ?", AudioFileType.find_by_name('jingle').id])
      if jingles.length > 0
        id = rand(jingles.length)
        $log.info "Scheduler: Requested the playback of a jingle #{jingles[id].path}"
        @liq.send(SCHEDULER_CONFIG[:liq_jingle].to_s).push jingles[id].path
        @last_jingle = Timer.now
        # FIXME Update jingle metric when playing it and take care of it when choosing jingle
      end
    end
  end

  def generate_playlist(task)
    length = @next.slot.end - @next.slot.start - @next.overrun
    if Timer.now > @next.slot.start and Timer.now < @next.slot.end
      length -= Timer.now - @next.slot.start
    end

    @current_playlist = @playlist_factory.make(@next.playlist, length * 60)
    overrun = @current_playlist.length / 60.0 - length
    $log.info "Scheduler: Generated playlist: asked #{length} minutes got #{@current_playlist.length / 60.0} (i.e. #{overrun} minute(s) of overrun)"
    overrun
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



  def next_task(overrun)
    # 10080 minutes is the length in minutes of a week
    # We are wrapping the end of the week here.
    slot = ::Slot.first(:conditions => {:start => @next.slot.end % 10080})
    pls = get_playlist_from_slot(slot)
    Task.new(slot, pls, overrun)
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
