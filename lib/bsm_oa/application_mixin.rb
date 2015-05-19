module BsmOa
  module ApplicationMixin
    extend ActiveSupport::Concern

    included do
      has_many :authorizations, class_name: BsmOa::Authorization, inverse_of: :application, dependent: :destroy
      has_many :roles, inverse_of: :applications, class_name: BsmOa::Role, through: :authorizations, foreign_key: :role_id

      serialize :permissions, Bsm::Model::Coders::JsonColumn.new(Array)
      validate  :must_have_simple_word_permissions

      before_validation :normalize_permissions!

      scope :ordered, -> { order(:name) }
    end

    def permissions_string=(permissions_string)
      self.permissions = permissions_string.split(/\W+/)
    end

    def permissions_string
      permissions.sort.join(' ')
    end

    protected

      def must_have_simple_word_permissions
        errors.add :permissions, :invalid if permissions.any? {|pm| pm =~ /[^a-z0-9]/ }
      end

      def normalize_permissions!
        self.permissions = Array.wrap(permissions).reject(&:blank?).map(&:strip).map(&:downcase).uniq
      end

  end
end

