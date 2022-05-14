require 'rails_helper'

describe 'User edits a supplier' do 
  it 'from the details page' do
    # Arrange
    Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                    registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                    city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'TECH VISION'
    click_on 'Editar'
    # Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Fantasia', with: 'TECH VISION')
    expect(page).to have_field('Razão Social', with: 'World Technology Vision LTDA')
    expect(page).to have_field('CNPJ', with: '43447216000102')
    expect(page).to have_field('Endereço', with: 'Av das Flores, 500')
    expect(page).to have_field('Cidade', with: 'Cajamar')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'tech_vision@gmail.com')
  end

  it 'successfully' do 
    # Arrange 
    Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                    registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                    city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'TECH VISION'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'TECH VISION'
    fill_in 'Razão Social', with: 'World Technology Vision LTDA'
    fill_in 'CNPJ', with: '43447216000102'
    fill_in 'Endereço', with: 'Av das Flores, 500'
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'CNPJ: 43447216000102'
    expect(page).to have_content 'Endereço: Av das Flores, 500'
    expect(page).to have_content 'E-mail: tech_vision@gmail.com'
    
  end

  it 'and keep the required fields' do 
    # Arrange 
    Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                    registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                    city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'TECH VISION'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor'  
  end
end