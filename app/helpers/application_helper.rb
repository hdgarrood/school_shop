module ApplicationHelper
  def quid(amount)
    number_to_currency(amount, :unit => "&pound;")
  end
end
