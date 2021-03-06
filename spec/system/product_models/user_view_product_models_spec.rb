require 'rails_helper'

describe 'User sees product models' do
  it 'if you are authenticated' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end  
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'from the menu' do
    # Arrange
    user = User.create!(email: 'aracele@email.com', password: 'password')
    # Act 
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
     end    
    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'successfully' do
    # Arrange
    user = User.create!(email: 'aracele@email.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
    ProductModel.create!(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                         depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround' , weight: 3000 , width: 80 , height: 15 , 
                        depth: 20 , sku: 'SOU71-LG-NTIO9563625' , supplier: supplier)
    
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end 
    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-LG-XPT090569743'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-LG-NTIO9563625'
    expect(page).to have_content 'LG'
  end

  it 'and there are no registered products' do
    # Arrange
    user = User.create!(email: 'aracele@email.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'

  end
end