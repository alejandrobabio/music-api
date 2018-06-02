class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.references :artist, polymorphic: true, index: true
    end
  end
end
