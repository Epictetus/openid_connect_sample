class CreateConnectFacebook < ActiveRecord::Migration
  def change
    create_table :connect_facebook do |t|
      t.belongs_to :account
      t.string :identifier, :access_token
      t.timestamps
    end
  end
end
