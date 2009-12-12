# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Creating default audio file types
AudioFileType.create([{:name => 'undefined', :metric => 0.0},
                      {:name => 'track', :metric => 1.0},
                      {:name => 'jingle', :metric => 1.0},
                      {:name => 'live', :metric => 1.0},
                      {:name => 'mix', :metric => 1.0},
                      {:name => 'program', :metric => 1.0}])

AudioFileStyle.create({:name => 'nostyle', :metric => 0.0})

Role.create([{:name => 'root', :desc => 'Super Power User de la mort'},
             {:name => 'administrateur', :desc => 'Administrateur, tout les droits sauf ceux qui concernent le systeme'},
             {:name => 'moderateur', :desc => 'Moderateur, suppression/edition du contenu'},
             {:name => 'contributeur', :desc => 'Peut avoir un compte ftp, liste les fichiers, peut gerer des plages horaires'}])

u = User.create(:username => 'root', :email => 'test@test.com',
                :password => 'hackme', :password_confirmation => 'hackme')
`echo "insert into role_assignments (user_id, role_id) values ('1', '1');" | sqlite3 db/development.sqlite3`

PlaylistPlayer.create([{:name => 'random', :desc => 'Super random heuristique'},
                       {:name => 'order', :desc => 'Joue la playlist dans l\'ordre'}])
PlaylistType.create([{:name => 'audiofile', :desc => 'playlist de fichiers'},
                     {:name => 'typestyle', :desc => 'la playlist est specifiee par le type et les styles de fichiers'}])
