# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create({name: 'category1'})
Category.create({name: 'category2'})
Idea.create({category_id: 1, body: 'idea1'})
Idea.create({category_id: 2, body: 'idea2'})