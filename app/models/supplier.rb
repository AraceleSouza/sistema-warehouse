class Supplier < ApplicationRecord
    has_many :product_models
    validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
    validates :registration_number , uniqueness: true
    validates :registration_number, length: { is: 14 }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
