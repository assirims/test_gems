class RenameCoursesShortDescriptionToMarketingDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :courses, :short_description, :marketing_description
  end
end
