class CreateCourses < ActiveRecord::Migration[7.0]
  # def change
  #   create_table :courses do |t|
  #     t.string :title
  #     t.text :description
  #     t.text :short_description
  #     t.string :language
  #     t.string :level
  #     t.integer :price

  #     t.timestamps
  #   end
  # end
  def change
    add_column :courses, :short_description, :text
    add_column :courses, :language, :string, default: "English", null: false
    add_column :courses, :level, :string, default: "Beginner", null: false
    add_column :courses, :price, :integer, default: "0", null: false
  end
end
