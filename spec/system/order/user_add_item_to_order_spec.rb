require 'rails_helper'

describe 'User adds items to order' do
  it 'successfully' do
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
    product_a = ProductModel.create!(name:'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PROD-A-XPT0905697432')
    product_b = ProductModel.create!(name:'Produto B', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier, sku: 'PROD-B-XPT0905697433')
    # Act
    login_as(user) 
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'and do not see products from another supplier' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                   address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                   description: 'Galpão destinado para cargas internacionais') 
    supplier_a = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                 registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                 city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    supplier_b = Supplier.create!(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', 
                                  registration_number: '45447228000105', full_address: 'Av das cerejeiras, 41', 
                                  city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')
    order = Order.create!(user: user , warehouse: warehouse, supplier:supplier_a, 
                                estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name:'Produto A', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier_a, sku: 'PROD-A-XPT0905697432')
    product_b = ProductModel.create!(name:'Produto B', weight: 15, width: 10, height: 20, depth: 30, 
                                    supplier: supplier_b, sku: 'PROD-B-XPT0905697433')
     # Act
     login_as(user) 
     visit root_path
     click_on 'Meus Pedidos'
     click_on order.code
     click_on 'Adicionar Item'
     # Assert
     expect(page).to have_content 'Produto A'
     expect(page).not_to have_content 'Produto B'
  end
end