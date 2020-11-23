# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([{ email: 'user1@tech.com', password: 'first_user_pass' },
                     { email: 'user2@tech.com', password: 'second_user_pass' }])
file_path = Rails.root.join('test', 'fixtures', 'images', 'dummy_photo.jpg')
photo = Photo.new(title: 'first photo', user: users.first)
photo.image_file.attach(io: File.open(file_path), filename: 'dummy_photo.jpg')
photo.save
