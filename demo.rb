require './movie_collection.rb'

movies =  MovieCollection.new('movies.txt')


puts movies.all
puts "\n\n"
puts "first 5 sort by :name"
puts movies.sort_by(:name).first(5)
puts "\n\n"
puts "first 5 sort by :date"
puts movies.sort_by(:date).first(5)
puts "\n\n"
puts "first 5 sort by :duration"
puts movies.sort_by(:duration).first(5)
puts "\n\n"
puts " error if sort by 'duration'"
puts movies.sort_by('duration')
puts "\n\n"
puts "movies.all.first.actors"
puts movies.all.first.actors
puts "\n\n"
puts "movies.all.first.href"
puts movies.all.first.href
puts "\n\n"
puts "Comedies"
puts movies.filter(genres: 'Comedy')
puts "\n\n"
puts "USA's films"
puts movies.filter(country: 'USA').first(5)
puts "\n\n"

puts "stats director"
puts movies.stats(:director)
puts "stats actor"
puts movies.stats(:actor)
puts "stats country"
puts movies.stats(:country)
puts "stats genre"
puts movies.stats(:genre)
puts "#{movies.all.first}  has genre Comedy?"
puts movies.all.first.has_genre?('Comedy')
puts "#{movies.all.first}  has genre Drama?"
puts movies.all.first.has_genre?('Drama')

begin
puts "#{movies.all.first}  has genre Tragedy?"
puts movies.all.first.has_genre?('Tragedy')
rescue RuntimeError => detail
  puts "RuntimeError is occured: #{detail}" 
end