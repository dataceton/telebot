class Wallet < ApplicationRecord
  belongs_to :user
  before_create -> { self.code = ([*10000..99999] - Wallet.distinct.pluck(:code)).sample }

  def self.top_up_balance(code, amount)
    self.find_by(code: code).try(:increment!, :balance, amount)
  end
end
