# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.create(email: "rtizzi@gmail.com", password: "Iamtheworst1")

3.times do |i|
  Band.create(name: "Band#{i}")
end

band0 = Band.first

5.times do |i|
  band0.albums << Album.create(band_id: band0.id,
                                set: "live",
                                title: "Album #{i}",
                                year: 1987)
end

4.times do |i|
  album = band0.albums[i]
  10.times do |j|
    album.tracks << Track.create(album_id: album.id,
                                  title: "Track #{j}",
                                  ord: j)
  end
end
