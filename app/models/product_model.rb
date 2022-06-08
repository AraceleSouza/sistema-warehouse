class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  validates :name, :weight , :width , :height , :depth , :sku, :supplier, presence: true
  validates :weight , :width , :height , :depth , numericality: { greater_than_or_equal_to: 1 }
  validates :sku, length: { is: 20 }
  validates :sku , uniqueness: true
end
