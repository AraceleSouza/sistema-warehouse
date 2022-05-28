require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
      warehouse = Warehouse.create!(name:'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: '2022-10-01')
      # Act
      result = order.valid?
      # Assert
      expect(result).to be true
    end

    it 'estimated delivery date must be mandatory' do
      # Arrange
      order = Order.new(estimated_delivery_date: ' ')
      # Act
      order.valid?
      result = order.errors.include? (:estimated_delivery_date)
      # Assert
      expect(result).to be true
    end
  
    it 'estimated delivery date must not be old' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)
      # Act
      order.valid?
      result = order.errors.include? (:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser posterior.")
    end

    it 'estimated delivery date should not be the same as today' do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)
      # Act
      order.valid?
      result = order.errors.include? (:estimated_delivery_date)
      # Assert
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser posterior.")
    end

    it 'estimated delivery date must be equal to or greater than tomorrow' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      # Act
      order.valid?
      result = order.errors.include? (:estimated_delivery_date)
      # Assert
      expect(result).to be false
    end
  end
  
  describe 'generate a random code' do
    it 'when creating a new order' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
      warehouse = Warehouse.create!(name:'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: '2022-10-01')
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'and the code is unique' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
      warehouse = Warehouse.create!(name:'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: '2022-10-01')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: '2022-11-15') 
      
      # Act
      second_order.save!
      #result =  second_order.code
      # Assert
      expect(second_order.code).not_to eq first_order.code     
    end
  end
end