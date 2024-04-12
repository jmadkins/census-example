# This should take the hash returned from a Census::*::LocalitiesMapper and
# return an array of ids for the localities
class Census::LocalityAdapter
  def initialize(state_id:, county_id:, localities_hash:)
    @state_id = state_id
    @county_id = county_id
    @localities_hash = localities_hash
  end

  def ids
    [].tap do |ids|
      ids << @county_id
      ids << precinct_id

      @localities_hash.each do |type, code|
        next if [:state, :county, :precinct_code, :precinct_name].include?(type)
        parent_id = [:county_court, :ward, :justice_peace].include?(type) ? @county_id : @state_id

        ids << Census::Operations.locality(type: type, code: code, parent_id: parent_id)
      end
    end.compact
  end

  private

  def precinct_id
    Census::Operations.locality(
      type: :precinct,
      code: @localities_hash[:precinct_code],
      parent_id: @county_id,
      name: @localities_hash[:precinct_name]
    )
  end
end
