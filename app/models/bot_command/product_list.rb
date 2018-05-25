module BotCommand
  class ProductList < Base
    ITEMS = %w[item1 item2]
    def should_start?
      # binding.pry
      ITEMS.include? data
    end

    def start
      if Product.any?
        buttons = Product.select(:name).distinct.map do |prod|
          Telegram::Bot::Types::InlineKeyboardButton.new(text: prod.name, callback_data: { name: prod.name, command: :price_list }.to_json)
        end
        reply_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
        send_message("Выберите", reply_markup: reply_markup)
      else
        send_message("К сожалению, на данный момент список товаров пуст.")
      end
      # user.reset_next_bot_command
      # user.set_next_bot_command('BotCommand::PriceList')
    end

  end
end