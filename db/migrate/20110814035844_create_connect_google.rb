class CreateConnectGoogle < ActiveRecord::Migration
  def change
    create_table :connect_google do |t|
      t.belongs_to :account
      t.string :identifier, :access_token, :id_token
      t.timestamps
    end
  end
end
