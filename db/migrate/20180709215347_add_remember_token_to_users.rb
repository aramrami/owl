# frozen_string_literal: true

# Add remember_token to users
class AddRememberTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remember_token, :string
  end
end
