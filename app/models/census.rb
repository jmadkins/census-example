# == Schema Information
#
# Table name: censuses
#
#  id               :bigint           not null, primary key
#  type             :string           not null
#  identifier       :string           not null
#  status           :string           not null
#  universe_id      :bigint
#  has_header_row   :boolean          default(FALSE), not null
#  column_headers   :string
#  delimiter        :string           default("csv"), not null
#  uploaded_by      :string           not null
#  mapping          :string
#  processor        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  row_count        :integer          default(0), not null
#  force_reprocess  :boolean          default(FALSE), not null
#  error_count      :integer          default(0), not null
#  finished_count   :integer          default(0), not null
#  sidekiq_batch_id :string
#
class Census < ApplicationRecord
  include AASM
  include Ingestable
  include Processable

  before_validation :set_identifier

  belongs_to :universe, optional: true
  has_many :census_rows, dependent: :delete_all
  has_many :census_batches, dependent: :delete_all

  validates :identifier, :status, :uploaded_by, presence: true

  aasm column: :status do
    state :analyzing, initial: true
    state :preparing, :processing, :halted, :errored, :disgarded, :finished

    event :finish_analyzing do
      transitions from: :analyzing, to: :preparing
    end

    event :start_processing do
      transitions from: %i[preparing halted errored], to: :processing
    end

    event :finish_processing do
      transitions from: %i[processing errored], to: :finished
    end

    event :finish_with_error do
      transitions from: :processing, to: :errored
    end

    event :halt do
      transitions from: %i[processing analyzing], to: :halted
    end

    event :reprocess do
      transitions from: %i[finished halted errored], to: :processing
    end

    event :discard do
      transitions from: %i[analyzing processing halted errored], to: :disgarded
    end
  end

  private

  def set_identifier
    self.identifier = SecureRandom.alphanumeric(10).upcase if identifier.blank?
  end
end
