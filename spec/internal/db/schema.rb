ActiveRecord::Schema.define do

  create_table :users do |t|
    t.string :email
  end

  create_table :roles_users, id: false do |t|
    t.integer :role_id
    t.integer :user_id
  end
  add_index :roles_users, [:role_id, :user_id], unique: true

end
