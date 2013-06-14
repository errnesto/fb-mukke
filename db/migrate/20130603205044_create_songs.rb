class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :image
      t.string :url
      t.string :source
      t.string :identifier
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
