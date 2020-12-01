// 1. Show title and special_features of films that are PG-13

db.films.find({'Special Features': 1}, {'Rating': {$eq: 'PG-13'}})

// 2. Get a list of all the different films duration.

db.films.distinct('Length')

// 3. Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00

db.films.find({'Title': 1, 'Rental Duration': 1, 'Replacement Cost': 1}, {'Replacement Cost': {$gte: '20.00', $lte: '24.00'}})

// 4. Show title, category and rating of films that have 'Behind the Scenes' as special_features

db.films.find({'Title': 1, 'Category': 1, 'Rating': 1}, {'Special Features': {$eq: 'Behind the Scenes'}})

// 5. Show first name and last name of actors that acted in 'ZOOLANDER FICTION'

db.films.findOne({'Actors.First Name': 1, 'Actors.Last Name': 1}, {'Title': {$eq: 'ZOOLANDER FICTION'}})

// 6. Show the address, city and country of the store with id 1

db.stores.findOne({'Address': 1, 'City': 1, 'Country': 1}, {'_id': 1})

// 7. Show pair of film titles and rating of films that have the same rating.

db.films.aggregate([{$group: {'_id': '$Rating', 'Films': {$push: {'Title': '$Title', 'Rating': '$Rating'}}}}])

// 8. Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).

db.stores.find({'_id':2}, {'_id':0, 'Staff.First Name':1, 'Staff.Last Name':1, 'Inventory.Film Title':1}) 