class CreateIdTokens < ActiveRecord::Migration
  def change
    create_table :id_tokens do |t|
      t.belongs_to :account, :client
      t.string :user_id
      t.datetime :expires_at
      t.timestamps
    end
  end
end