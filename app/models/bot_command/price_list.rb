module BotCommand
  class PriceList < Base
    ITEMS = %w[item1 item2]
    def should_start?
      # binding.pry
      ITEMS.include? data
    end

    def start
      buttons = Product.where(name: data[:name]).uniq(&:weight).map do |prod|
        Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{prod.weight}гр./#{prod.price}руб.", callback_data: { name: prod.name,
                                                                                                                     weight: prod.weight,
                                                                                                                     command: :purchase }.to_json)
      end
      button = Telegram::Bot::Types::InlineKeyboardButton.new(text: "some text", pay: true)
      reply_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
      edit_message("\xE2\xAC\x87")
      send_photo("http://apikabu.ru/img_n/2012-11_5/yex.jpg", reply_markup: reply_markup)
    end
  end
end