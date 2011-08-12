class CreateAuthorizationCodes < ActiveRecord::Migration
  def change
    create_table :authorization_codes do |t|
      t.belongs_to :account, :client
      t.string :code, :redirect_uri
      t.datetime :expires_at
      t.timestamps
    end
  end
end
