class LineItem < ApplicationRecord
  include FieldSearchable
  include StatusReviewable

  belongs_to :campaign

  delegate :name, prefix: :campaign, to: :campaign

  def billable_amount
    actual_amount + adjustments
  end
end
