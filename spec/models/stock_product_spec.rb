require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'generate a serial number' do
    it 'when creating a StockProduct' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
      warehouse = Warehouse.create!(name:'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, 
                                    height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-PT05697423')
      # Act
      stock_poduct = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      # Assert
      expect(stock_poduct.serial_number.length).to eq 20
    end

    it 'and is not modified' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
      warehouse = Warehouse.create!(name:'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, 
                                  description: 'Alguma descrição')
      other_warehouse = Warehouse.create!(name:'Guarulhos', code: 'GRU', address: 'Endereço',
                                  cep: '15000-000', city: 'Guarulhos', area: 1000, 
                                  description: 'Galpão de SP')
      supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, 
                                    height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-PT05697423')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number
      # Act
      stock_product.update(warehouse: other_warehouse)
      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
