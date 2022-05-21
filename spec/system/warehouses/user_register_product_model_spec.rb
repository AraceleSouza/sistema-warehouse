require 'rails_helper'

describe 'User registers a product model' do 
  it 'successfully' do
    # Arrange
    user = User.create!(email: 'aracele@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
    other_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447302000103', full_address: 'Av das Flores 125',
                                city: 'São Paulo', state: 'SP', email: 'contato@sansung.com')
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32 polegadas'
    fill_in 'Altura', with: '45'
    fill_in 'Largura', with: '70'
    fill_in 'Peso', with: '8_000'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'TV40-LG-XPT090569743'
    select 'LG', from: 'Fornecedor'
    click_on 'Enviar'

  
    # Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 32 polegadas'
    expect(page).to have_content 'Fornecedor: LG'
    expect(page).to have_content 'SKU: TV40-LG-XPT090569743'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'must fill in all fields' do
    # Arrange
    user = User.create!(email: 'aracele@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                  registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                  city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ' '
    fill_in 'Altura', with: ' '
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'
  end 

 
end