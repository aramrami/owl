# frozen_string_literal: true

# CreateDuckStatuses
class CreateDuckStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :duck_statuses & :timestamps
  end
end
