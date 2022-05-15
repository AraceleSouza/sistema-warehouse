require 'rails_helper'

describe 'User sees suppliers' do
  it 'from the menu' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
     click_on 'Fornecedores'
    end
    # Assert
    expect(current_path).to eq suppliers_path
  end

  it 'successfully' do
    # Arrange
      Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
      Supplier.create!(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', registration_number: '45447228000105', 
                      full_address: 'Av das cerejeiras, 41', city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')         
    # Act
    visit root_path
    click_on 'Fornecedores'
    # Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('TECH VISION')
    expect(page).to have_content('Cajamar - SP')
    expect(page).to have_content('Mundo Eletronicos')
    expect(page).to have_content('Salvador - BA')
  end

  it 'and there are no registered suppliers' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    # Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end

end