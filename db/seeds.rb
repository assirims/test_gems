# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.create!(email: 'qme@msn.com', password: '000000', password_confirmation: '000000')

# user = User.new(
#   email: 'admin@example.com',
#   password: 'admin@example.com',
#   password_confirmation: 'admin@example.com'
# )
# user.skip_confirmation!
# user.save!

# 30.times do
#   Course.create!([{
#     title: Faker::Educator.course_name,
#     # description: Faker::Quote.matz,
#     description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
#     # user_id: User.first.id,
#     # short_description: Faker::Quote.famous_last_words,
#     short_description: Faker::Lorem.sentence(word_count: 20, supplemental: true, random_words_to_add: 4),
#     # language: Faker::ProgrammingLanguage.name,
#     language: ['English', 'Spanish', 'Russian'].sample,
#     level: ['Beginner', 'Intermediate', 'Advanced'].sample,
#     price: Faker::Number.between(from: 0, to: 200),
#     user_id: User.first.id
#   }])
# end

20.times do
  User.create!([{
    email: Faker::Internet.email,
    password: '000000',
    created_at: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
    updated_at: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
    sign_in_count: Faker::Number.between(from: 0, to: 100),
    current_sign_in_at: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
    last_sign_in_at: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
    current_sign_in_ip: Faker::Internet.ip_v4_address,
    last_sign_in_ip: Faker::Internet.ip_v4_address,
    confirmed_at: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
}])
end

#   // Console
# bundle
# rails db:seed
