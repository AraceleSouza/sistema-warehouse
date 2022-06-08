require 'rails_helper'

describe 'User sees their own orders' do
  it 'and must be authenticated' do
    # Arrange

    # Act
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'and see no other orders' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                        description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                        registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                        city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com') 

    first_order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now, status: 'pending')
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now, status: 'delivered')
    third_order = Order.create!(user: user, warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now, status: 'canceled')
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content second_order.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Cancelado'
  end

  it 'and visit an order' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                        description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                        registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                        city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com') 

    first_order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code
    # Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: World Technology Vision LTDA'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'and does not visit requests from other users' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                        description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                        registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                        city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com') 

    first_order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(carla)
    visit order_path(first_order.id)
    # Assert
    expect(current_path).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path  
    expect(page).to have_content 'Você não possui acesso a este pedido.' 
  end

  it 'and see order items' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                        registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                        city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com') 
    product_a = ProductModel.create!(name:'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PROD-A-XPT0905697432')
    product_b = ProductModel.create!(name:'Produto B', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PROD-B-XPT0905697433')
    product_c = ProductModel.create!(name:'Produto C', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PROD-C-XPT0905697434')

    user = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                        description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now, status: 'pending')

    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    # Assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'
  end
end