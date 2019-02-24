class CreateDuckStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :duck_statuses do |t|

      t.timestamps
    end
  end
end
