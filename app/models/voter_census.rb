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
class VoterCensus < Census
end
