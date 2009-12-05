# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Creating default audio file types
AudioFileType.create([{:name => 'track', :metric => 1.0},
                      {:name => 'jingle', :metric => 1.0},
                      {:name => 'live', :metric => 1.0},
                      {:name => 'mix', :metric => 1.0},
                      {:name => 'program', :metric => 1.0}])

AudioFileStyle.create({:name => 'nostyle', :metric => 0.0})

Role.create([{:name => 'root', :desc => 'Super Power User de la mort'},
             {:name => 'Administrateur', :desc => 'Administrateur, tout les droits sauf ceux qui concernent le systeme'},
             {:name => 'Moderateur', :desc => 'Moderateur, suppression/edition du contenu'},
             {:name => 'Contribeur', :desc => 'Peut avoir un compte ftp, liste les fichiers, peut gerer des plages horaires'}])

