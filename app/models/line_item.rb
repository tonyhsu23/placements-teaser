class LineItem < ApplicationRecord
  include FieldSearchable
  include AASM

  belongs_to :campaign

  delegate :name, prefix: :campaign, to: :campaign

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

  def billable_amount
    actual_amount + adjustments
  end
end
