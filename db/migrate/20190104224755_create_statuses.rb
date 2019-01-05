class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :title
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
