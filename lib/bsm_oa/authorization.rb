module BsmOa
  class Authorization < ActiveRecord::Base
    self.table_name = :"#{table_name_prefix}bsm_oa_authorizations#{table_name_suffix}"

    # ---> ASSOCIATIONS
    belongs_to :role, inverse_of: :authorizations
    belongs_to :application, inverse_of: :authorizations, class_name: Doorkeeper::Application, foreign_key: :application_id

    # ---> ATTRIBUTES
    serialize :permissions, Bsm::Model::Coders::JsonColumn.new(Array)
    attr_readonly :application_id, :role_id, :application

    # ---> VALIDATIONS
    validates :application, :role, :application_id, :role_id, presence: :true
    validates :application_id, uniqueness: { scope: :role_id }

    # ---> CALLBACKS
    before_validation :normalize_permissions!

    # ---> SCOPES
    scope :ordered, -> { order(id: :desc) }

    # @param [String] name permission name
    def toggle(name)
      if permissions.include?(name)
        self.permissions = permissions - [name]
      else
        self.permissions = permissions + [name]
      end
      save
    end

    def permissions_string=(str)
      self.permissions = str.split("\s")
    end

    def permissions_string
      permissions.sort.join(' ')
    end

    protected

      def normalize_permissions!
        self.permissions = permissions.reject(&:blank?).map(&:strip).map(&:downcase).uniq
        self.permissions &= application.permissions if application
      end

  end
end
