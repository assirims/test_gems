class AddImpressionsToUserLesson < ActiveRecord::Migration[7.0]
  def change
    add_column :user_lessons, :impressions, :integer, default: 0, null: false
  end
end
