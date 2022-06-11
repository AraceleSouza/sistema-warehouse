class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/ }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
