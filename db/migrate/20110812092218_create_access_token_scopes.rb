class CreateAccessTokenScopes < ActiveRecord::Migration
  def change
    create_table :access_token_scopes do |t|
      t.belongs_to :access_token, :scope
      t.timestamps
    end
  end
end
