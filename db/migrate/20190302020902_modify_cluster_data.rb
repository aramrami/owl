class ModifyClusterData < ActiveRecord::Migration[5.1]
	def change
		remove_column :clusterdata, :content, :string
		add_column :clusterdata, :event_type, :string
		add_column :clusterdata, :payload, :json
		add_column :clusterdata, :papa_duck_id, :string
  end
end
