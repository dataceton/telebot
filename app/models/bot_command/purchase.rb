module BotCommand
  class Purchase < Base
    def start
      product = Product.find_by(name: data[:name], weight: data[:weight])
      if !product.present?
        answer_callback("Данный отвар отсутсвует")
      elsif @wallet.balance >= product.price
        # binding.pry
        # edit_message("\xE2\xAC\x87")
        # prod
        # delete_message
        # send_message("\xE2\xAC\x87")
        # Faraday::UploadIO.new(photo, 'image/png')
        product.photos.each { |photo| send_photo(photo)}
        send_location(product.latitude, product.longitude)
      else
        # send_message("У вас недостаточно средств. Пополните баланс.")
         answer_callback("У вас недостаточно средств. Пополните баланс.")
      end
    end
  end
end