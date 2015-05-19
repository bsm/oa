json.(@account, *BsmOa.config.user_attrs)

json.authorizations @account.authorizations.includes(:application) do |auth|
  json.uid auth.application.uid
  json.permissions auth.permissions
end if @account.respond_to?(:authorizations)

