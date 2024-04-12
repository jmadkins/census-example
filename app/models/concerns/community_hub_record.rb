module CommunityHubRecord
  extend ActiveSupport::Concern

  included do
    include Sluggable
    include UniverseScoped
    include Cloneable

    has_rich_text :body
    has_rich_text :success_message
    has_one_attached :cover_image, dependent: :destroy

    validates :community_hub_visibility, presence: true

    enum community_hub_visibility: {
      visible: "visible",
      restricted: "restricted",
      hidden: "hidden"
    }

    # WARNING: the order of the flag options CAN NOT be changed
    flag :capture_address_flag, [:street, :city, :state, :zip]

    def friendly_body
      return if body.blank?

      body.to_plain_text.gsub(/\[.*?\] /, "").strip
    end

    def capture_address?
      capture_address_flag.any?
    end

    def capture_street?
      capture_address_flag.set?(:state)
    end

    def capture_city?
      capture_address_flag.set?(:city)
    end

    def capture_state?
      capture_address_flag.set?(:state)
    end

    def capture_zip?
      capture_address_flag.set?(:zip)
    end

    def community_hub?
      community_hub_visibility != "hidden"
    end
  end
end
