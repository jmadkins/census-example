# == Schema Information
#
# Table name: census_batches
#
#  id         :bigint           not null, primary key
#  census_id  :bigint           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CensusBatch < ApplicationRecord
  belongs_to :census
  has_many :rows, dependent: :nullify, class_name: "CensusRow"

  validates :name, presence: true, uniqueness: {scope: :census_id}

  before_validation :set_name

  def self.size
    5000
  end

  def process_later
    CensusBatchJob.perform_async id
  end

  private

  def set_name
    self.name = SecureRandom.hex if name.blank?
  end
end
