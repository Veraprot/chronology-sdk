# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
laura = User.new
laura.username = 'lk'
laura.email = 'l@k.com'
laura.password = '1111'
laura.password_confirmation = '1111'
laura.save
user = User.new
user.username = 'veraprot'
user.email = 'vera.protopopova@gmail.com'
user.password = '1111'
user.password_confirmation = '1111'
user.save
