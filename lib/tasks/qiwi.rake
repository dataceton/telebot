require 'net/http'
require 'qiwi/hash'
include Qiwi::Hash

namespace :qiwi do
  desc "TODO"
  task payment_check: :environment do
    p "task has been started"
    token = Rails.application.secrets.qiwi_token
    wallet = Rails.application.secrets.qiwi_wallet
    uri = URI("https://edge.qiwi.com/payment-history/v2/persons/#{wallet}/payments")
    params = { rows: 1, operation: "IN" }
    uri.query = URI.encode_www_form(params)
    headers = {'Content-Type': 'application/json', 'Authorization': "Bearer #{token}", 'Accept': 'application/json'}
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, headers)
    response = https.request(request)
    last_txnId = JSON.parse(response.body).txn_id
    counter = 0
    message = ""
    loop do
      begin
        resp = https.request(request)
        resp_body = JSON.parse(resp.body)  
      rescue Exception => e
        p e
      end
      if resp_body.present? && resp_body.txn_id != last_txnId
        p "Вам переверил: #{resp_body.amount} руб."
        p "С комментарием: #{resp_body.comment}"
        Wallet.top_up_balance(resp_body.comment, resp_body.amount)
        last_txnId = resp_body.txn_id
      else
        begin
          message = counter == 0 ? "#{resp.code}" : ""  
        rescue Exception => e
          p e
        end
        message += "." if counter < 80
        message += "\n" if counter == 80
        print message
        counter = counter == 80 ? 0 : counter += 1
        sleep(2)
      end
    end
  end
end
