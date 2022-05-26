require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    click_on 'Registrar Pedido'
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    Warehouse.create(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, 
                      address: 'Av Atlantica, 50',cep: '80000-000', 
                      description: 'Perto do Aeroporto')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    
    Supplier.create!(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', 
                      registration_number: '45447228000105', full_address: 'Av das cerejeiras, 41', 
                      city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')     
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
        
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: Aeroporto SP'
    expect(page).to have_content 'Fornecedor: World Technology Vision LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergio | sergio@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Galpão Maceio'
    expect(page).not_to have_content 'Mundo Eletrônicos LTDA'
  end
end