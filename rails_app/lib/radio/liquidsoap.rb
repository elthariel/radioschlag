##
## liquidsoap.rb
## Login : <opp2@opp2-devsrv>
## Started on  Mon Jan 11 10:36:58 2010 opp2
## $Id$
##
## Author(s):
##  - Julien 'Lta' BALLET <elthariel@gmail.com>
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

require 'socket'

module Radio

class LiquidSoapProxy
  def initialize(socket, name = '')
    @name = name
    @socket = socket
  end

  def method_missing(sym, *args)
    if exists? sym
      LiquidSoapProxy.new(@socket, sym.to_s)
    else
      arg_str = args.join(' ')
      if (@name == '')
        exec("#{sym} #{arg_str}")
      else
        exec("#{@name}.#{sym} #{arg_str}")
      end
    end
  end

  def exists?(sym)
    list = exec('list')

    list.each do |item|
      if item.chomp =~ /#{sym}/
        return true
      end
    end
    return false
  end

  def exec(str)
    result = Array.new

    @socket.puts str

    while (line = @socket.gets.chomp) != 'END'
      result.push line
    end

    result
  end

end

class LiquidSoap
  def initialize(path)
    begin
      @socket = UNIXSocket.open(path)
    rescue
      puts "Unable to connect to liquidsoap socket #{path}"
      exit 42
    end
  end

  # Arguments with space must be quoted or escaped
  def method_missing(sym, *args)
    LiquidSoapProxy.new(@socket).send(sym, args)
  end

end

end

