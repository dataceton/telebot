class User < ApplicationRecord
  has_one :wallet, dependent: :destroy

  after_create -> { self.create_wallet }
  validates_uniqueness_of :telegram_id

  def set_next_bot_command(command)
    self.bot_command_data = command
    save
  end

  def get_next_bot_command
    bot_command_data
  end

  def reset_next_bot_command
    self.bot_command_data = nil
    save
  end
end
