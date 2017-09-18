module BsmOa
  class Application < Doorkeeper::Application

    has_many :authorizations, class_name: 'BsmOa::Authorization', inverse_of: :application, dependent: :destroy
    has_many :roles, inverse_of: :applications, class_name: 'BsmOa::Role', through: :authorizations, foreign_key: :role_id

    serialize :permissions, JSON
    validate  :must_have_simple_word_permissions

    before_validation :normalize_permissions!

    scope :ordered, -> { order(:name) }

    # @param [Array|String] permissions
    def permissions=(vals)
      super Array.wrap(vals).map {|s| s.to_s.split(/[\s,]+/) }.flatten
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

