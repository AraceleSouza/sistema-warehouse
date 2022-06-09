require 'rails_helper'

describe 'User informs new order status' do
  it 'and order was delivered' do
    # Arrange
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, 
                                    height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-PT05697423')
    order = Order.create!(user: carla , warehouse: warehouse, supplier:supplier, 
                                estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)
    # Act
    login_as(carla)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(estoque).to eq 5
  end

  it 'and order was canceled' do
    # Arrange
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    order = Order.create!(user: carla , warehouse: warehouse, supplier:supplier, 
                                estimated_delivery_date: 1.day.from_now, status: :pending)
    # Act
    login_as(carla)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Cancelado')
  end
end