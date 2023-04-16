class AddIncomeToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :income, :integer, default: 0, null: false
  end
end
