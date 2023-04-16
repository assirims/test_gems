class AddBalanceFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :balance, :integerr, default: 0, null: false
    add_column :users, :course_income, :integerr, default: 0, null: false
    add_column :users, :enrollment_expences, :integerr, default: 0, null: false
  end
end
