class CreateIdTokens < ActiveRecord::Migration
  def change
    create_table :id_tokens do |t|
      t.belongs_to :account, :client
      t.datetime :expires_at
      t.timestamps
    end
  end
end