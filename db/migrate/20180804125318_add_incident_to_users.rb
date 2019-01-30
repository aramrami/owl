# frozen_string_literal: true

# Add incident to users
class AddIncidentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :incident, :integer
  end
end
