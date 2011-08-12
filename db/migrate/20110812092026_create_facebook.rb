class CreateFacebook < ActiveRecord::Migration
  def change
    create_table :facebook do |t|
      t.belongs_to :account
      t.string :identifier, :access_token
      t.timestamps
    end
  end
end
