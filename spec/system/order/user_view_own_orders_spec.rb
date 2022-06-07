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
                                        estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(user: user, warehouse: warehouse, supplier:supplier, 
                                        estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end

  it 'and visit an order' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
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
end