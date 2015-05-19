class BsmOaAddPermissionsToOauthApplications < ActiveRecord::Migration
  def change
    add_column :oauth_applications, :permissions, :text
  end
end
