# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(email: 'Admin@gmail.com', password: 'Admin@123', user_type: 'Instructor')
user_id = user.id
User.create(email: 'Admin1@gmail.com', password: 'Admin1@123', user_type: 'Trainee')
Instructor.create(user_id: user_id, first_name: 'Sheena', last_name: 'Sheena')

