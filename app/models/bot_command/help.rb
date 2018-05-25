module BotCommand
  class Help < Base
    def start
      send_message("По всем возникшим вопросам обращайтесь: 'номер тг'")
    end
  end
end