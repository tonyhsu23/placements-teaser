module Currency
  extend ActiveSupport::Concern

  def currency_to_number(currency)
    currency.to_s.gsub(/[$,]/,'').to_f
  end
end
