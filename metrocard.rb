class Metrocard
  COST_PER_RIDE = 275
  MIN_FOR_BONUS = 550
  BONUS_AMOUNT  = 0.11

  def initialize(balance)
    @balance = to_pennies(balance)
  end

  def optimize_with_max_budget(budget)
    @budget = to_pennies(budget)

    optimal_values.map { |pennies| to_dollars(pennies) }
  end

  private

  attr_reader :balance, :budget

  def optimal_values
    (0..budget).step(5).select { |added| optimal_value?(added) }
  end

  def optimal_value?(added)
    prospective_balance(added) % COST_PER_RIDE == 0
  end

  def prospective_balance(added)
    balance + added + bonus_with(added)
  end

  def bonus_with(added)
    return 0 unless added >= MIN_FOR_BONUS
    (added * BONUS_AMOUNT).round
  end

  def to_pennies(dollar_amount)
    (dollar_amount * 100).to_i
  end

  def to_dollars(pennies)
    dollars = (pennies / 100).to_s

    pennies = (pennies % 100).to_s
    pennies << '0' if pennies.length < 2

    "$#{dollars}.#{pennies}"
  end
end
