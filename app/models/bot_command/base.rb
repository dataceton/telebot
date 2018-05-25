require 'telegram/bot'

module BotCommand
  class Base
    attr_reader :user, :webhook, :api

    def initialize(user, webhook)
      @user = user
      @wallet = @user.wallet
      @webhook = webhook
      @api = ::Telegram::Bot::Api.new(Rails.application.secrets.bot_token)
    end

    def should_start?
      raise NotImplementedError
    end

    def start
      raise NotImplementedError
    end

    protected

    def send_message(text="", options={})
      @api.call('sendMessage', { chat_id: @user.telegram_id, text: text, parse_mode: "Markdown" }.merge(options))
    end

    def edit_message(text="", options={})
      @api.call('editMessageText', { chat_id: @user.telegram_id, message_id: message_id, text: text }.merge(options))
    end

    def delete_message
      @api.call('deleteMessage', chat_id: @user.telegram_id, message_id: message_id)
    end

    def send_photo(image_path, options={})
      @api.call('sendPhoto', { chat_id: @user.telegram_id, photo: image_path }.merge(options))
    end

    def send_location(latitude, longitude, options={})
      @api.call('sendLocation', { chat_id: @user.telegram_id, latitude: latitude, longitude: longitude }.merge(options))
    end

    def answer_callback(text="")
      @api.call('answerCallbackQuery',callback_query_id: data[:id], text: text, show_alert: true)
    end

    def text
      @webhook[:message][:text]
    end

    def data
      @webhook[:callback_data]
    end

    def message_id
      @webhook[:message][:message_id]
    end
  end
end