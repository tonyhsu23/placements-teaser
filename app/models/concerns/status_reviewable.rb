module StatusReviewable
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm :status do
      state :unreviewed, initial: true
      state :reviewed

      event :review do
        transitions from: :unreviewed, to: :reviewed
      end

      event :rollback do
        transitions from: :reviewed, to: :unreviewed
      end
    end
  end
end
