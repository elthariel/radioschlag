##
## scheduler.rb
## Login : <opp2@opp2-devsrv>
## Started on  Sun Jan 10 21:47:49 2010 opp2
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

require 'rubygems'
require 'logger'
require 'radio/timer'
require 'radio/liquidsoap'
require 'radio/scheduler'
require 'radio/pool'

$log = Logger.new SCHEDULER_CONFIG[:logfile]
$log.level = Logger.const_get SCHEDULER_CONFIG[:loglevel].to_sym

t = Radio::Timer.new
l = Radio::LiquidSoap.new(SCHEDULER_CONFIG[:liq_socket])
s = Radio::Scheduler.new(l)
s.tick

#t.seconds.connect Proc.new {puts "tick #{Time.now}"; true}
#t.minutes.connect Proc.new {s.tick}
t.seconds.connect Proc.new {s.tick}



t.run




