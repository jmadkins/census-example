# Apply to a Model that has an attribute named `slug`
module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :slugify!
    validates :slug, uniqueness: {scope: :universe}
  end

  def slugify!
    # We allow blank names to account for uploaded UniverseFiles
    if name.blank?
      self.slug = "#{SecureRandom.hex(6)}-#{SecureRandom.hex(4)}"
    elsif slug.blank?
      self.slug = "#{name.parameterize}-#{SecureRandom.hex(4)}"
    end
  end
end
