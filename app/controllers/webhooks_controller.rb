class WebhooksController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def callback
    # binding.pry
    products_params = []
    products = webhook[:message][:text].split("\n")
    keys = [:weight, :latitude, :longitude, :description, :photos]
    product_name = products.shift

    products.each do |item|
      product = {name: product_name}
      values = item.split(';')
      product.merge!(keys.zip(values).to_h)
      products_params << product
    end
    Product.create(products_params)
    binding.pry
    BotMessageDispatcher.new(user, message: webhook[:message], callback_data: callback_data).process
    render nothing: true, head: :ok

  end

  def index
    render json: Product.all
  end

  def webhook
    params[:webhook][:callback_query] || params[:webhook] 
  end

  def callback_data
    webhook[:data] ? JSON.parse(webhook[:data]).merge(id: webhook[:id]).with_indifferent_access : nil
  end

  def from
    webhook[:from] || webhook[:message][:from]
  end

  def user
    @user ||= User.find_by(telegram_id: from[:id]) || register_user
  end

  def register_user
    @user = User.find_or_initialize_by(telegram_id: from[:id])
    @user.update_attributes(first_name: from[:first_name], last_name: from[:last_name])
    @user.save
  end
end
