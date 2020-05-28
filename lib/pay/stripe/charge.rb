module Pay
  module Stripe
    module Charge
      extend ActiveSupport::Concern

      def stripe?
        processor == "stripe"
      end

      def stripe_charge
        ::Stripe::Charge.retrieve(processor_id)
      rescue ::Stripe::StripeError => e
        raise Error, e.message
      end

      def stripe_refund!(amount_to_refund, options)
        args = {
          charge: processor_id,
          amount: amount_to_refund
        }.merge(options)

        ::Stripe::Refund.create(args)

        update(amount_refunded: amount_to_refund)
      rescue ::Stripe::StripeError => e
        raise Error, e.message
      end
    end
  end
end
