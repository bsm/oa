module BsmOa
  class Authorization < ActiveRecord::Base
    self.table_name = :"#{table_name_prefix}bsm_oa_authorizations#{table_name_suffix}"

    # ---> ASSOCIATIONS
    belongs_to :role, inverse_of: :authorizations
    belongs_to :application, inverse_of: :authorizations, class_name: 'BsmOa::Application', foreign_key: :application_id

    # ---> ATTRIBUTES
    serialize :permissions, JSON
    attr_readonly :application_id, :role_id, :application

    # ---> VALIDATIONS
    validates :application, :role, :application_id, :role_id, presence: :true
    validates :application_id, uniqueness: { scope: :role_id }

    # ---> CALLBACKS
    before_validation :normalize_permissions!

    # ---> SCOPES
    scope :ordered, -> { order(id: :desc) }

    # @param [String] name permission name
    def toggle_permission!(name)
      update permissions: (permissions.include?(name) ? permissions - [name] : permissions + [name])
    end

    # @param [Array|String] permissions
    def permissions=(vals)
      super Array.wrap(vals).map {|s| s.to_s.split(/[\s,]+/) }.flatten
    end

    protected

      def normalize_permissions!
        self.permissions ||= []
        self.permissions = permissions.reject(&:blank?).map(&:strip).map(&:downcase).uniq
        self.permissions &= application.permissions if application
      end

  end
end
