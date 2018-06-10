class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :song, foreign_key: true, index: true
      t.string :title
      t.text :image_data
    end
  end
end
