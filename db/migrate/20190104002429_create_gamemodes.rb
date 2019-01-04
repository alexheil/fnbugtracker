class CreateGamemodes < ActiveRecord::Migration[5.0]
  def change
    create_table :gamemodes do |t|

      t.timestamps
    end
  end
end
