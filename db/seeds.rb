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

