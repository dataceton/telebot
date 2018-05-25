class Product < ApplicationRecord
  # validates :name, :price, :weight, :latitude, :longitude, :photos, presence: true
  # before_create -> { self.code = ([*1000..9999] - Product.distinct.pluck(:code)).sample }
  before_create :some_method

  def photos
    self.photos.split(',')
  end

  # def photos=(urls)
  #   self.photos = urls.delete('\\"')
  # end

  def some_method
    binding.pry
  end
end
