class AddCounterCacheToUserLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :user_lessons_count, :integer, default: 0, null: false
    Lesson.find_each { |lesson| Lesson.reset_counters(lesson.id, :user_lessons) }
    add_column :users, :user_lessons_count, :integer, default: 0, null: false
    User.find_each { |user| User.reset_counters(user.id, :user_lessons) }
  end
end
