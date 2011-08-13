class CreateAuthorizationScopes < ActiveRecord::Migration
  def change
    create_table :authorization_scopes do |t|
      t.belongs_to :authorization, :scope
      t.timestamps
    end
  end
end
