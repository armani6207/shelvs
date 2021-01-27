class CreateLibraries < ActiveRecord::Migration[5.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.integer :user_id
      t.integer :book_id
    end
  end
end
