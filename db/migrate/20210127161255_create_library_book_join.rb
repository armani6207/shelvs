class CreateLibraryBookJoin < ActiveRecord::Migration[5.1]
  def change
    create_join_table(:libraries, :books)
  end
end
