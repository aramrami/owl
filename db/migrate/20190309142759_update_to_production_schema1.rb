class UpdateToProductionSchema1 < ActiveRecord::Migration[5.1]
	def change
		rename_column :clusterdata, :papa_duck_id, :device_id
		add_column :clusterdata, :uuid, :string
		add_column :clusterdata, :device_type, :string

		create_table :android_debug_messages do |t|
			t.json :payload
			t.string :uuid
			t.string :from_device_id
			t.string :from_device_type
			t.timestamps
		end

		create_table :device_observations do |t|
			t.string :device_id
			t.string :device_type
			t.string :latitude
			t.string :longitude
			t.datetime :observation_timestamp
			t.timestamps
		end

		create_table :devices do |t|
			t.string :device_type
			t.string :device_id
			t.string :auth_token
			t.timestamps
		end
  end
end
