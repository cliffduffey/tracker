class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :type
      t.string :host_name
      t.string :ip_address
      t.string :mac_address

      t.timestamps
    end
  end
end
