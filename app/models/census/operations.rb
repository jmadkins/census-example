module Census::Operations
  def self.find_locality_id(type, code, parent_id)
    Locality.locate_with_cache(type, code, parent_id).limit(1).first&.id
  rescue
    nil
  end

  # a `nil` code means the voter does not live in a locality of that type
  def self.locality(type:, code:, parent_id:, name: nil)
    return if code.blank?

    find_locality_id(type, code, parent_id) || Locality.find_or_create_by!(
      locality_type: type,
      code: code,
      name: name || code,
      parent_locality_id: parent_id
    ).id
  end
end
