class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :account, :client
      t.string :code, :redirect_uri
      t.datetime :expires_at
      t.timestamps
    end
  end
end
