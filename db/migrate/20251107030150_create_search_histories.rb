class CreateSearchHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :search_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :keyword

      t.timestamps
    end
  end
end
