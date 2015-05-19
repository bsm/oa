class BsmOaCreateRoles < ActiveRecord::Migration
  def change
    create_table :bsm_oa_roles do |t|
      t.string :name, null: false, size: 80
      t.string :description
    end
    add_index :bsm_oa_roles, [:name], unique: :true
  end
end
