##
## default-prog.rb
## Login : <opp2@opp2-devsrv>
## Started on  Mon Dec  7 15:47:54 2009 opp2
## $Id$
##
## Author(s):
##  - opp2 <>
##
## Copyright (C) 2009 opp2
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

programs = {:nuit => ["De tout, c'est la nuit faut en profiter", 0, 6],
  :matin => ['Une selection plutot posee pour se reveiller tranquillement', 6, 12],
  :apres_midi => ['Un truc plutot energique et happy pour donner la motive jusko soir', 12, 18],
  :soir => ["On attaque dans le lourd, il fait nuit c'est la teuf", 18, 24]}
days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']

programs.each do |k, v|
  Program.new(:name => k.to_s, :desc => v[0]).save
end

for day in 0 .. 6 do
  programs.each do |k, v|
    prog = Program.find_by_name(k.to_s)
    Slot.create(:name => "#{days[day]} #{k.to_s}", :desc => v[0],
                :start => day * 24 * 60 + v[1] * 60,
                :end => day * 24 * 60 + v[2] * 60,
                :program_id => prog.id)
  end
end


