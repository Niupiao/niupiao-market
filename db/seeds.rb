User.create(first_name: 'Ryan', last_name: 'Kwon', email: 'rynkwn@gmail.com', password: 'phoenix')
user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password')
item = user.items.create(name: 'Item', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Great', 'Useful', 'Cheap'])
review = item.reviews.build(user_id: user.id, body: 'Alright', rating: 5)
review.save