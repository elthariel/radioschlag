##
## authorization_rules.rb
## Login : <opp2@opp2-devsrv>
## Started on  Fri Dec  4 22:41:08 2009 opp2
## $Id$
##
## Author(s):
##  - Julien 'Lta' BALLET <>
##
## Copyright (C) 2009 Julien 'Lta' BALLET
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

authorization do
  role :root do
    includes :administrateur

    has_permission_on :role_assignments, :to => :manage
    has_permission_on :ftp_accounts, :to => :manage
  end

  role :administrateur do
    includes :moderateur

    has_permission_on :users, :to => :manage
    has_permission_on :programs, :to => :manage
    has_permission_on :slots, :to => :manage
    has_permission_on :program_assignments, :to => :manage
  end

  role :moderateur do
    includes :contributeur

    has_permission_on :incoming_audio_files, :to => :destroy
    has_permission_on :audio_files, :to => :manage
    has_permission_on :playlist_assignments, :to => :manage
  end

  role :contributeur do
    includes :guest

    # Fichier audios
    has_permission_on :audio_files, :to => :manage do
      if_attribute :user => is {user}
    end

    # Les contribs peuvent voir leur quota
    has_permission_on :ftp_accounts, :to => :read do
      if_attribute :user => is {user}
    end

    # Fichiers audios en conversion
    has_permission_on :incoming_audio_files, :to => :read
    has_permission_on :incoming_audio_files, :to => :delete do
      if_attribute :user => is {user}
    end

    # Les contributeurs gerent les styles
    has_permission_on :audio_file_styles, :to => :manage

    # Les contributeurs peuvent gerer des playlists
    has_permission_on :playlists, :to => :create
    has_permission_on :playlists do
      to :manage, :add_file, :sort_file, :remove_file, :add_style, :remove_style, :update_style_metric
      if_attribute :user => is {user}
    end

    # Les contributeurs peuvent ajouter des playlist a leur programes
    #has_permission_on :playlist_assignments, :to => :manage do
    #  if_attribute :users => contains {user}
    #end
  end

  role :guest do
    has_permission_on :audio_files, :to => :read
    has_permission_on :playlists, :to => [:read, :create]
    has_permission_on :role_assignment, :to => :read
    has_permission_on :users, :to => :create
    has_permission_on :users, :to => :update do
      if_attribute :user => is {user}
    end
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end

