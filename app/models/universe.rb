# == Schema Information
#
# Table name: universes
#
#  id                             :bigint           not null, primary key
#  candidate_name                 :string
#  email                          :string
#  invoice_prefix                 :string
#  name                           :string           not null
#  public                         :boolean          default(FALSE), not null
#  slug                           :string           not null
#  status                         :string           not null
#  stripe_identifier              :string
#  treasurer_name                 :string
#  website                        :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  election_id                    :bigint
#  election_locality_id           :bigint
#  federation_id                  :bigint
#  organization_id                :bigint           not null
#  voter_search_state_locality_id :bigint
#
class Universe < ApplicationRecord
  include AASM
  include FederationScoped
  include Searchable
  include Mailable
  include Stats

  belongs_to :organization
  belongs_to :election, optional: true
  belongs_to :election_locality, class_name: "Locality", optional: true
  belongs_to :voter_search_state_locality, class_name: "Locality", optional: true

  has_many :access_credentials, dependent: :destroy
  has_many :accounts, dependent: :destroy, inverse_of: :tenant, foreign_key: :tenant_id, class_name: "Plutus::Account"
  has_many :brandings, class_name: "UniverseBranding"
  has_many :call_sessions, dependent: :destroy
  has_many :canvasses, dependent: :destroy
  has_many :censuses, dependent: :destroy, class_name: "UniverseCensus"
  has_many :contacts, dependent: :destroy
  has_many :contribution_matrices, dependent: :destroy
  has_many :data_forms, dependent: :destroy
  has_many :disclosures, dependent: :destroy, class_name: "FinancialDisclosure"
  has_many :email_messages, dependent: :destroy
  has_many :email_subscriptions, dependent: :destroy
  has_many :email_templates, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :files, dependent: :destroy, class_name: "UniverseFile"
  has_many :folders, dependent: :destroy
  has_many :integrations, dependent: :destroy, class_name: "UniverseIntegration"
  has_many :invoices, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :mail_topics, dependent: :destroy
  has_many :mailboxes, dependent: :destroy
  has_many :multiverse_universes, dependent: :destroy
  has_many :news_posts, dependent: :destroy
  has_many :online_profiles, as: :trackable, dependent: :destroy
  has_many :petitions, dependent: :destroy
  has_many :postcard_shipments, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :reporting_periods, dependent: :destroy
  has_many :scripts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tax_rates, dependent: :destroy
  has_many :trackable_links, dependent: :destroy
  has_many :universe_users, dependent: :destroy
  has_many :user_subscriptions, dependent: :destroy
  has_many :volunteer_duties, dependent: :destroy
  has_many :workflows, dependent: :destroy

  has_one :primary_address, class_name: "Address", through: :organization, source: :primary_address
  has_one :community_hub, class_name: "UniverseSite", dependent: :destroy
  has_one :actblue_access_credential, class_name: "AccessCredentials::Actblue"
  has_one :goodchange_access_credential, class_name: "AccessCredential::GoodChange"
  has_one :license, through: :federation

  has_many :users, through: :universe_users, source: :user, class_name: "User"
  has_many :canvass_attempts, through: :canvasses, source: :attempts
  has_many :canvass_turfs, through: :canvasses, source: :turfs
  has_many :contribution_asks, through: :contacts
  has_many :contribution_pledges, through: :contacts
  has_many :contribution_commitments, through: :contacts
  has_many :contributions, through: :contacts
  has_many :expenses, through: :contacts
  has_many :email_transactions, through: :email_messages, source: :transactions
  has_many :email_recipients, through: :email_transactions, source: :recipients
  has_many :interactions, through: :contacts
  has_many :multiverses, through: :multiverse_universes
  has_many :voter_leads, through: :contacts
  has_many :contact_volunteer_duties, through: :contacts
  has_many :tasks, through: :projects
  has_many :task_statuses, through: :projects

  has_one_attached :candidate_headshot, dependent: :destroy
  has_one_attached :logo, dependent: :destroy
  has_rich_text :description
  has_rich_text :invoice_memo
  has_rich_text :invoice_footer

  accepts_nested_attributes_for :community_hub, :online_profiles, :organization

  before_validation :slugify!
  after_create :provision_now
  delegate :public_name, to: :organization

  validates :name, presence: true, uniqueness: {scope: :federation}
  validates :slug, presence: true, uniqueness: {scope: :federation}
  validates :status, presence: true

  scope :accessible_to_logged_in_users, -> {
    joins(:license).includes(:federation)
      .visible_to_logged_in_users
      .merge(Federation.active)
      .merge(License.valid)
  }
  scope :visible_to_logged_in_users, -> { where(status: %i[active chilled suppressed]) }

  # active - normal status with no restrictions
  # chilled/frozen - users may login but in a read-only mode
  # suppressed - active, but public interactions are not allowed
  # suspended - suspended by a super user
  # nuked - async destruction
  aasm column: :status do
    state :active, initial: true
    state :chilled, :suppressed, :suspended, :nuked

    event :chill do
      transitions from: :active, to: :chilled

      after do
        federation.decrease_universe_count
      end
    end

    event :thaw do
      transitions from: :chilled, to: :active

      after do
        federation.increase_universe_count
      end
    end

    event :activate do
      transitions to: :active
    end

    event :suppress do
      transitions from: %i[created active], to: :suppressed
    end

    event :suspend do
      transitions to: :suspended
    end

    event :nuke do
      transitions to: :nuked

      after do
        federation.decrease_universe_count
        UniverseDestroyJob.perform_async(id, Current.user.id)
      end
    end
  end

  def ids_for
    if has_multiverses?
      MultiverseUniverse
        .where(multiverse_id: multiverse_universes.select(:multiverse_id))
        .pluck(:universe_id)
        .uniq
    else
      [id]
    end
  end

  def slugify!
    self.slug = name.parameterize if name.present?
  end

  def has_multiverses?
    multiverse_universes.any?
  end

  def owner
    universe_users.active.find_sole_by(access_level: Hubble::Access::OWNER).user
  end

  OnlineProfile::NETWORKS.each do |network|
    define_method :"#{network.value}_profile_name" do
      return instance_variable_get(:"@#{network.value}_profile_name") if instance_variable_defined?(:"@#{network.value}_profile_name")

      records = online_profiles.find_by(network_name: network.value)
      instance_variable_set(:"@#{network.value}_profile_name", records&.profile_name)
    end
  end

  private

  def provision_now
    mark_current_user_as_owner

    Tag.create_default(self)
    GeneralLedger.create_default(self) # do this regardless of license

    VolunteerDuty.create_default(self) if license.volunteer_hub?
    UniverseSite.create_default(self) if license.community_hub?

    if license.finance_hub?
      AccessCredentials::Actblue.create_default(self)
      ReportingPeriod.create_default(self)
    end

    if license.communication_hub?
      Mailbox.create_default(self) if email.present?
      MailTopic.create_default(self)
      EmailTemplate.create_default(self)
    end
  end

  def provision_later
    UniverseProvisionJob.perform_async(id, Current.user.id)
  end

  def mark_current_user_as_owner
    return if Current.user.nil?

    universe_users.create!(
      user: Current.user,
      access_level: Hubble::Access::OWNER,
      requested_at: Time.current,
      approved_at: Time.current,
      approved_by: Current.user
    )
    UserSubscription.create_defaults(universe: self, user: Current.user)
  end
end
