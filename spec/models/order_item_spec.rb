require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    it 'quantity must be mandatory' do
      # Arrange
      order_item = OrderItem.new(quantity: ' ')
      # Act
      order_item.valid?
      result = order_item.errors.include? (:quantity)
      # Assert
      expect(result).to be true
    end
  end    
end
