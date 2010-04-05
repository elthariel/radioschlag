#! /usr/bin/ruby
## playlist_maker_random.rb
## Login : <elthariel@rincevent>
## Started on  Sat Apr  3 12:38:54 2010 elthariel
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

module BTree
  class Node
    attr_reader :label, :left, :right

    def initialize(label, left = nil, right = nil)
      @label = label
      @left = left
      @right = right
    end

    def isLeaf?
      left == nil and right == nil
    end

    def isNode?
      !isLeaf?
    end

    # Use when debugging your probability tree
    def print(level = 0)
      pad = String.new

      level.times { pad += "\t" }
      if @left
        @left.print(level + 1)
      end
      puts "#{pad}#{label}"
      if @right
        @right.print(level + 1)
      end
    end
  end
end

class RandomPlaylistMaker
  def initialize
  end

  def make(active_record_playlist_object, pool, seconds)
    active_pls = active_record_playlist_object
    # Are we allowing? a track to be more than once in a playlist
    replay = seconds * 2 >= pool.length
    pls = Array.new
    length = 0

    puts "RandomPlaylistMaker: Generating new playlist"

    poolmap = build_itermediate_filelist(pool)
    tree = build_probability_tree(poolmap)

    #tree.print

    while length < seconds do
      track = toss_the_ball(tree, poolmap[poolmap.length - 1][0])
      if !replay and track.instance_variable_get(:@played)
        next
      end
      pls.push track.label
      length += track.label.duration
      # FIXME We should not update metric of some files (jingle for example)
      track.label.metric += SCHEDULER_CONFIG[:audiofile_metric_increment]
      track.instance_variable_set(:@played, true)
      track.label.save

    end

    Playlist.new(pls, length)
  end

  private
  def toss_the_ball(tree, max)
    ball = rand * max
    current = tree

    #puts "The ball is #{ball}"

    while (current.isNode?) do
      if (ball <= current.label)
        #puts "left: #{ball} <= #{current.label}"
        current = current.left
      else
        #puts "right: #{ball} > #{current.label}"
        current = current.right
      end
    end
    current
  end

  def build_probability_tree(poolmap)
    _rec_build_tree(poolmap, 0, poolmap.length - 1, poolmap.length / 2)
  end

  def _rec_build_tree(poolmap, start_index, end_index, pivot)
    #    puts "start: #{start_index}\t end: #{end_index} \tpivot: #{pivot}"
    if (start_index == end_index)
      BTree::Node.new(poolmap[start_index][1])
    else
      BTree::Node.new(poolmap[pivot][0],
                     _rec_build_tree(poolmap, start_index, pivot, (pivot - start_index) / 2 + start_index),
                     _rec_build_tree(poolmap, pivot + 1, end_index, (end_index - pivot + 1) / 2 + pivot))
    end
  end

  def build_itermediate_filelist(pool)
    probability = 0
    pool.files.map { |f| [probability += f[1], f[0]] }
  end
end
end

if __FILE__ == $0
  maker = Radio::RandomPlaylistMaker.new
  list = Array.new
  list.push [1, 'test']
  list.push [3, 'test1']
  list.push [5.5, 'test2']
  list.push [6.23, 'test3']
  list.push [8, 'test4']
  list.push [12, 'test5']
  list.push [15, 'test6']

  maker.build_probability_tree(list).print
end
