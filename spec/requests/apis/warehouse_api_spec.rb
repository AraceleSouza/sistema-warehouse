require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouse/1' do
    it 'success' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
      # Act
      get "/api/v1/warehouses/#{warehouse.id}"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it 'fail if warehouse not found' do
      # Arrange

      # Act
      get "/api/v1/warehouses/999999"
      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'list all warehouses ordered by name' do
      # Arrange
      Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
      Warehouse.create!(name: 'Cuiaba', code:'CWB', area: 10000, cep:'56000-000',
                                  city: 'Cuiaba', description: 'Galpão no centro do país',
                                    address: 'Av dos Jacarés, 100')
      # Act
      get "/api/v1/warehouses"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "Aeroporto SP"
      expect(json_response[1]["name"]).to eq "Cuiaba"
    end
    
    it 'return empty if there is no warehouse' do
      # Arrange
      
      # Act
      get "/api/v1/warehouses"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'success' do
      # Arrange
      warehouse_params  = { warehouse: { name: 'Aeroporto Internacional', code: 'GRU',
                            city: 'Guarulhos', area: 100_000,
                            address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                            description: 'Galpão destinado para cargas internacionais'}
                           }
      # Act
      post "/api/v1/warehouses", params: warehouse_params
      # Assert
      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto Internacional')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response["city"]).to eq('Guarulhos')
      expect(json_response["area"]).to eq(100_000)
      expect(json_response["address"]).to eq('Avenida do Aeroporto, 1000')
      expect(json_response["cep"]).to eq('15000-000')
      expect(json_response["description"]).to eq('Galpão destinado para cargas internacionais')
    end
  end
end