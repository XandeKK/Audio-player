# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed to test in development
music_file = File.open("#{Rails.root}/test/fixtures/files/music/time-for-love.mp3")
image_cover_file = File.open("#{Rails.root}/test/fixtures/files/image/time-for-love.jpg")

10.times do
  user = User.create!(
    name: Faker::Name.name,
    artistic_name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: "password"
  )
  2.times do
    music = Music.new(title: Faker::Name.name)
    music.music.attach(io: music_file, filename: "#{Faker::Name.name}.mp3")
    music.image_cover.attach(io: image_cover_file, filename: "#{Faker::Name.name}.jpg")
    music.save

    music_file.rewind
    image_cover_file.rewind

    Author.create!(user: user, music: music)
  end
end