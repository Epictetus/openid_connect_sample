class CreateAuthorizationCodeScopes < ActiveRecord::Migration
  def change
    create_table :authorization_code_scopes do |t|
      t.belongs_to :authorization_code, :scope
      t.timestamps
    end
  end
end
