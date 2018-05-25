class BotMessageDispatcher
  attr_reader :user, :webhook

  TYPES = {
    'help' => BotCommand::Help,
    'product_list' => BotCommand::ProductList,
    'wallet' => BotCommand::Wallet,
    'start' => BotCommand::Start,
    'price_list' => BotCommand::PriceList,
    'purchase' => BotCommand::Purchase
  }

  def initialize(user, webhook)
    @user = user
    @webhook = webhook
  end

  def process
    @user.super_user
    command_type = @webhook[:callback_data] ? @webhook[:callback_data][:command] : I18n.t(@webhook[:message][:text].scan(/[а-яА-Яa-zA-Z]/).join.downcase)
    bot_command = TYPES[command_type] || BotCommand::Undefined
    bot_command.new(user, @webhook).start
  end

  # private

  # def unknown_command
  #   BotCommand::Undefined.new(user,nil,).start
  # end
end