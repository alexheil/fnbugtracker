class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.references :user
      t.references :gamemode
      t.string :title
      t.text :description
      t.text :video_data
      t.text :image_data
      t.integer :status, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
