class BsmOaCreateTables < ActiveRecord::Migration
  def change
    create_table :bsm_oa_authorizations do |t|
      t.integer :role_id, null: false
      t.integer :application_id, null: false
      t.text    :permissions
    end
    add_index :bsm_oa_authorizations, [:role_id, :application_id], unique: :true

    create_table :bsm_oa_roles do |t|
      t.string :name, null: false, size: 80
      t.string :description
    end
    add_index :bsm_oa_roles, [:name], unique: :true
  end
end
