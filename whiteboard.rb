def optimize_metrocard(balance, budget)
  penny_budget = (budget * 100).floor
  penny_balance = (balance * 100).floor

  collected = (0..penny_budget).step(5).each_with_object([]) do |added_value, collection|
    bonus = added_value >= 550 ? (added_value * 0.11).round : 0
    total = penny_balance + added_value + bonus
    collection << added_value if total % 275 == 0
  end

  collected.map { |pennies| to_dollar(pennies) }
end

def to_dollar(pennies)
  dollars = (pennies / 100).to_s

  pennies = (pennies % 100).to_s
  pennies << '0' if pennies.length < 2

  "$#{dollars}.#{pennies}"
end
