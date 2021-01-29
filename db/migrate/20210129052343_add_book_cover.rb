class AddBookCover < ActiveRecord::Migration[5.1]
  def change
    add_column(:books, :cover, :binary)
  end
end
