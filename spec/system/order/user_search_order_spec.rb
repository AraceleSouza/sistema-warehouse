require 'rails_helper'

describe 'User searches for an order' do
  it 'from the menu' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    # Act
    login_as(user)
    visit root_path
    # Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'and must be authenticated' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_field('Buscar Pedido')
    expect(page).not_to have_button('Buscar')
  end

  it 'and find an order' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: World Technology Vision LTDA'
  end
end 