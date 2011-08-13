class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :account
      t.string :identifier, :secret, :name, :redirect_uri
      t.timestamps
    end
  end
end
