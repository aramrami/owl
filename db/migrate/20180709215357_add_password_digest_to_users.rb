# frozen_string_literal: true

# Add password_digest to users
class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
