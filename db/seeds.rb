# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(email: 'Admin@gmail.com', password: 'Admin@123', user_type: 'Instructor')
User.create(email: 'Admin1@gmail.com', password: 'Admin1@123', user_type: 'Trainee')
User.create(email: 'Trainee1@gmail.com', password: 'Trainee1@123', user_type: 'Trainee')
User.create(email: 'Trainee2@gmail.com', password: 'Trainee2@123', user_type: 'Trainee')
User.create(email: 'Trainee3@gmail.com', password: 'Trainee3@123', user_type: 'Trainee')
User.create(email: 'Trainee4@gmail.com', password: 'Trainee4@123', user_type: 'Trainee')
User.create(email: 'Trainee5@gmail.com', password: 'Trainee5@123', user_type: 'Trainee')
Instructor.create(user_id: 1, first_name: 'Admin First Name', last_name: 'Admin Last Name' )
Trainee.create(user_id: 2, full_name:'Admin1 Full Name', height:1.5, weight:90)
Trainee.create(user_id: 3, full_name:'Trainee1 Full Name', height:2, weight:100)
Trainee.create(user_id: 4, full_name:'Trainee2 Full Name', height:1.7, weight:95)
Trainee.create(user_id: 5, full_name:'Trainee3 Full Name', height:1.7, weight:95)
Trainee.create(user_id: 6, full_name:'Trainee4 Full Name', height:1.7, weight:95)
Trainee.create(user_id: 7, full_name:'Trainee5 Full Name', height:1.7, weight:95)
