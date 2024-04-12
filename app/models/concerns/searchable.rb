module Searchable
  extend ActiveSupport::Concern

  included do
    scope :autocomplete, ->(query, limited_select = false) do
      base = query.blank? ? all : where("name ILIKE ?", "%#{query}%")
      base = base.order(:name)
      limited_select ? base.select(:id, :name) : base
    end
  end
end
