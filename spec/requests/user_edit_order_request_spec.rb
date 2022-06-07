require 'rails_helper'

describe 'User edits order' do
  it 'and is not the owner' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'123456')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password:'123654')    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais') 
    supplier = Supplier.create!(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
    order = Order.create!(user: carla , warehouse: warehouse, supplier:supplier, 
                                estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    patch(order_path(order.id), params: { order: {supplier_id: 3}})
    # Assert
    expect(response).to redirect_to(root_path)
  end
end