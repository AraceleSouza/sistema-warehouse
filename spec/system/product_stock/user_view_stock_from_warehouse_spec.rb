require 'rails_helper'

describe 'User sees stock' do 
  it 'on the warehouse screen' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier:supplier, 
                          estimated_delivery_date: 1.day.from_now)
    product_tv = ProductModel.create!(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                      depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
    product_soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround' , weight: 3000 , width: 80 , height: 15 , 
                                            depth: 20 , sku: 'SOU71-LG-NTIO9563625' , supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook Dell i5 16GB' , weight: 2000 , width: 40 , height: 9 , 
                                            depth: 20 , sku: 'NOTE-DELL-NTIO956225' , supplier: supplier)
    3.times{ StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    2.times{ StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook)}
    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    # Assert
    within("section#stock_products") do
    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV32-LG-XPT090569743'
    expect(page).to have_content '2 x NOTE-DELL-NTIO956225'
    expect(page).not_to have_content 'SOU71-LG-NTIO9563625'
    end
  end

  it 'and write off an item' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier:supplier, 
                          estimated_delivery_date: 1.day.from_now)
    product_tv = ProductModel.create!(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                      depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
    2.times{ StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV32-LG-XPT090569743', from: 'Item para saída'
    fill_in 'Destinatário' , with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'
    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x TV32-LG-XPT090569743'
  end
end

