class CreateUserAuthorizationTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_authorization_tokens do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
    add_index :user_authorization_tokens, :token, unique: true
    add_index :user_authorization_tokens, :user_id
  end
end
