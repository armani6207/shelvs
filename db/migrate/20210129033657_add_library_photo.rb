class AddLibraryPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column(:libraries, :cover, :binary)
  end
end
