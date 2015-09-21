module BsmOa
  class Role < ActiveRecord::Base
    self.table_name = :"#{table_name_prefix}bsm_oa_roles#{table_name_suffix}"

    # ---> ASSOCIATIONS
    has_many :authorizations, inverse_of: :role, dependent: :destroy
    has_many :applications, inverse_of: :roles, class_name: 'BsmOa::Application', through: :authorizations, foreign_key: :application_id

    # ---> VALIDATIONS
    validates :name,
      presence: true,
      length: { maximum: 80, allow_blank: true },
      uniqueness: { case_sensitive: false, allow_blank: true }

    # ---> SCOPES
    scope :ordered, -> { order(id: :desc) }

    # ---> CALLBACKS
    before_validation :normalize_attributes!

    private

      def normalize_attributes!
        self.name = name.try(:strip)
      end

  end
end
