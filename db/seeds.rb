User.create(first_name: 'Ryan', last_name: 'Kwon', email: 'rynkwn@gmail.com', password: 'phoenix', address: "1216 Whitestone Dr., Murphy, TX")
user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', address: "55 Main St, North Adams, MA 01247")
User.create(first_name: "Person", last_name: "A", email: "per@son.com", password: 'person', address: "67 Main St, North Adams, MA 01247")
item = user.items.create(name: 'Item', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Great', 'Useful', 'Cheap'])
item = user.items.create(name: 'Baby Stroller', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Baby', 'Stroller', 'Cheap'])
item = user.items.create(name: 'Baby Food', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Baby', 'Food', 'Healthy'])
item = user.items.create(name: 'Baby Sweater', price: 10, quantity: 10, desc: 'Test item', item_type: 'Clothing', tags: ['Baby', 'Sweater', 'Warm'])
item = user.items.create(name: 'Moisturizing Shampoo', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Skin', 'Healthy', 'Shampoo', 'Moisturizing'])
item = user.items.create(name: 'Clear-Skin Aloe', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Skin', 'Healthy', 'Aloe', 'Clear'])
item = user.items.create(name: 'Marcay Primer', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Marcay', 'Makeup', 'Primer'])
review = item.reviews.build(user_id: user.id, body: 'Alright', rating: 5)
review.save
review = item.reviews.create(user_id: user.id, body: 'Alright', rating: 5)

Driver.create(name: 'Foo Bar', phone: '1234567890', bank_info: '0987654321', key: 'a')
Driver.create(name: 'Android Test', phone: '1234567890', bank_info: '0987654321', key: 'androidTestDriver')

