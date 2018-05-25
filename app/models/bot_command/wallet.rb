module BotCommand
  class Wallet < Base
    def start
      message = "*Баланс:* #{@wallet.balance}руб.\n" \
                "*Код кошелька:* #{@wallet.code}\n\n" \
                "Чтобы пополнить баланс переведите деньги на qiwi *+#{Rails.application.secrets.qiwi_wallet}*, в комментарии укажите код кошелька"
                 # Чтобы пополнить кошелёк переведите деньги на qiwi +#{Rails.application.secrets.qiwi_wallet} с кодом #{@wallet.code}"
      send_message(message)
    end
  end
end