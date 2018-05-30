class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :type
      t.string :name
      t.text :bio
    end
    add_index :artists, [:type, :id]
  end
end
