module BotCommand
  class Undefined < Base
    def start
      send_message('Не понимаю о чем ты. Напиши /start если хочешь начать')
      user.reset_next_bot_command
    end
  end
end