# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Destination.create(
    name: Faker::HitchhikersGuideToTheGalaxy.location,
    description: Faker::Hipster.paragraph,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    street_address: Faker::Address.street_address,
    author_id: rand(1..10)
  )
  RoadTrip.create(
    author_id: rand(1..10),
    name: Faker::Book.title,
    description: Faker::Hipster.paragraph,
    total_miles: rand(200..2000)
  )
  Tag.create(
    name: Faker::Hipster.word
  )
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    miles_driven: rand(100..200000)
  )
end

20.times do
  UserRoadTrip.create(
    user_id: rand(1..10),
    road_trip_id: rand(1..10),
    status: ["In Process", "Completed"].sample
  )
  DestinationTag.create(
    destination_id: rand(1..10),
    tag_id: rand(1..10)
  )
  RoadTripDestination.create(
    destination_id: rand(1..10),
    road_trip_id: rand(1..10),
    destination_order: rand(1..10)
  )
  Comment.create(
    body: Faker::Hipster.sentence,
    author_id: rand(1..10),
    commentable_id: rand(1..10),
    commentable_type: RoadTrip
  )
  Comment.create(
    body: Faker::Hipster.sentence,
    author_id: rand(1..10),
    commentable_id: rand(1..10),
    commentable_type: Destination
  )
  Picture.create(
    url: "https://picsum.photos/400/200?random",
    imageable_id: rand(1..10),
    imageable_type: User
  )
  Picture.create(
    url: "https://picsum.photos/400/200?random",
    imageable_id: rand(1..10),
    imageable_type: RoadTrip
  )
  Picture.create(
    url: "https://picsum.photos/400/200?random",
    imageable_id: rand(1..10),
    imageable_type: Destination
  )
end

User.create(
  name: "admin",
  email: "admin@admin.com",
  password: "password",
  admin: true
)

User.create(
  name: "Mayor Junius Bobbledoonary",
  email: "mayor@thewall.com",
  password: "password",
  admin: false
)
