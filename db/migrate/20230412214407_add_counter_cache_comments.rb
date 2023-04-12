class AddCounterCacheComments < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :comments_count, :integer, null: false, default: 0
    User.find_each { |user| User.reset_counters(user.id, :comments) }
    add_column :lessons, :comments_count, :integer, null: false, default: 0
    Lesson.find_each { |lesson| Lesson.reset_counters(lesson.id, :comments) }
  end
end
