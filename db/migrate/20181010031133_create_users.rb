class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.integer :team_id

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :team_id
  end
end
