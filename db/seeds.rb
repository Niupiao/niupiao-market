# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password')
item = user.items.create(name: 'Item', price: 10, quantity: 10, desc: 'Test item', type: 'General"'
review = item.reviews.build(user_id: user.id, body: 'Alright', rating: 5)
review.save