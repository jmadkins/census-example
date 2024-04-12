module Cloneable
  extend ActiveSupport::Concern

  included do
    def self.clone!(id)
      record = find(id).dup.tap do |record|
        record.name = "#{record.name} (Clone)"
        record.slug = nil if record.respond_to?(:slug)
        record.community_hub_visibility = "hidden" if record.respond_to?(:community_hub_visibility)
        record.active = false if record.respond_to?(:active)
      end
      record.save!
      record
    end

    def self.deep_clone!(id)
      record = find(id).deep_clone.tap do |record|
        record.name = "#{record.name} (Clone)"
        record.slug = nil if record.respond_to?(:slug)
        record.community_hub_visibility = "hidden" if record.respond_to?(:community_hub_visibility)
        record.active = false if record.respond_to?(:active)
      end
      record.save!
      record
    end
  end
end
