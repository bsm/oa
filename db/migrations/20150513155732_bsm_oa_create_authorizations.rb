class BsmOaCreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :bsm_oa_authorizations do |t|
      t.integer :role_id, null: false
      t.integer :application_id, null: false
      t.text :permissions

    end
    add_index :bsm_oa_authorizations, [:role_id, :application_id], unique: :true
  end
end
