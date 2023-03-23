# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.create!(email: 'qme@msn.com', password: '000000', password_confirmation: '000000')

30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    # description: Faker::Quote.matz,
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
    # user_id: User.first.id,
    # short_description: Faker::Quote.famous_last_words,
    short_description: Faker::Lorem.sentence(word_count: 20, supplemental: true, random_words_to_add: 4),
    # language: Faker::ProgrammingLanguage.name,
    language: ['English', 'Spanish', 'Russian'].sample,
    level: ['Beginner', 'Intermediate', 'Advanced'].sample,
    price: Faker::Number.between(from: 0, to: 200),
    user_id: User.first.id
  }])
end

#   // Console
# bundle
# rails db:seed
