# frozen_string_literal: true

# Create claims table
class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.string :file
      t.text :description

      t.timestamps
    end
  end
end
