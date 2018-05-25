module BotCommand
  class Start < Base

    def should_start?
      text =~ /\A\/start/
    end

    def start
      # if @user.super_user?
        keyboard = [[{ text: "Добавить" }]]
      # else
        # keyboard = [[{ text: "\xF0\x9F\x93\x9C  Список" }, { text: "\xF0\x9F\x92\xB0 Кошелек" }, { text: "\xE2\x9D\x93 Помощь" }]]
      # end
      send_message("Привет!", reply_markup: { keyboard: keyboard, resize_keyboard: true }.to_json)
      # loop do
      #   sleep(1)
      #   counter += 1
      # end
    end
  end
end