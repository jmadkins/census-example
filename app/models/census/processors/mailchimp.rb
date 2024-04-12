class Census
  module Processors
    class Mailchimp < BaseProcessor
      def execute
        @contact = upsert_contact
        subscribe_contact
      end

      private

      # handles creating the contact with the correct email
      def upsert_contact
        Operations::UpsertContact.invoke @mapper.attributes.merge!(universe_id: @census.universe_id)
      end

      def subscribe_contact
        subscription = EmailSubscription.find_or_initialize_by(
          universe_id: @census.universe_id,
          email_address: @contact.email_addresses.find_by(address: @mapper.email)
        )
        subscription.status = :subscribed
        subscription.mail_topics = @contact.universe.mail_topics.active
        subscription.save!
      end
    end
  end
end
