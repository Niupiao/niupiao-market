#, address: "1216 Whitestone Dr., Murphy, TX"
#, address: "55 Main St, North Adams, MA 01247"
#, address: "67 Main St, North Adams, MA 01247"
SuperAdmin.create(username: "batjinboldbat", password: "boldbat")
SuperAdmin.create(username: "rhk1", password: "phoenix")

u = User.create(first_name: 'Ryan', last_name: 'Kwon', email: 'rynkwn@gmail.com', password: 'phoenix')
u.generate_auth_token
user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password')
user.generate_auth_token
User.create(first_name: "Person", last_name: "A", email: "per@son.com", password: 'person')
user.items.create(name: 'Item', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Great', 'Useful', 'Cheap'])
user.items.create(name: 'Baby Stroller', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Baby', 'Stroller', 'Cheap'])
user.items.create(name: 'Baby Food', price: 10, quantity: 10, desc: 'Test item', item_type: 'General', tags: ['Baby', 'Food', 'Healthy'])
user.items.create(name: 'Baby Sweater', price: 10, quantity: 10, desc: 'Test item', item_type: 'Clothing', tags: ['Baby', 'Sweater', 'Warm'])
user.items.create(name: 'Moisturizing Shampoo', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Skin', 'Healthy', 'Shampoo', 'Moisturizing'])
user.items.create(name: 'Clear-Skin Aloe', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Skin', 'Healthy', 'Aloe', 'Clear'])
item = user.items.create(name: 'Marcay Primer', price: 10, quantity: 10, desc: 'Test item', item_type: 'Beauty', tags: ['Marcay', 'Makeup', 'Primer'])
phone = Phone.create(manufacturer: "microsoft", origin: "mars", best: 1)
phone.item = item
review = item.reviews.build(user_id: user.id, body: 'Alright', rating: 5)
review.save
review = item.reviews.create(user_id: user.id, body: 'Alright', rating: 5)

Driver.create(name: 'Foo Bar', phone: '1234567890', bank_info: '0987654321', key: 'a')


# Seeding Domain tables.
Supercategory.create!(name: "Beauty") # 1
Supercategory.create!(name: "Baby") # 2

Category.create!(name: "Makeup") # 1
Category.create!(name: "SkinCare") # 2
Category.create!(name: "Fragrance") # 3 
Category.create!(name: "BathAndBody") # 4
Category.create!(name: "Nails") # 5
Category.create!(name: "Hair") # 6
Category.create!(name: "BabyAndToddlerClothing") # 7
Category.create!(name: "Feeding") # 8
Category.create!(name: "BeddingAndDecor") # 9
Category.create!(name: "ActivitiesAndToys") # 10 
Category.create!(name: "HealthAndSafety") # 11