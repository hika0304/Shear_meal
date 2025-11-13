class AddProfileToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age_group, :string
    add_column :users, :gender, :string
    add_column :users, :goal, :string
  end
end
