require 'rails_helper'

describe 'User edits order' do
  it 'and must be authenticated' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                estimated_delivery_date: 1.day.from_now)
    # Act
    visit edit_order_path(order.id)
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'successfully' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    Supplier.create!(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', registration_number: '45447228000105', 
                      full_address: 'Av das cerejeiras, 41', city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')         
    order = Order.create!(user: user , warehouse: warehouse, supplier:supplier, 
                                estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select 'Mundo Eletrônicos LTDA', from: 'Fornecedor'
    click_on 'Gravar'
    # Arrange
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
    expect(page).to have_content 'Fornecedor: Mundo Eletrônicos LTDA'
  end
end