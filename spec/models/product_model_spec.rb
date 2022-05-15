require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: '' , weight: 8000 , width: 70 , height: 45 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when weight is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: 'TV 32' , weight: '' , width: 70 , height: 45 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when width is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: '' , height: 45 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when height is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 70 , height: '' , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when depth is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                        depth: '' , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when sku is empty' do
        # Arrange
        supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
        product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                        depth: 10 , sku: '' , supplier: supplier)
        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false 
      end
    end

    it 'false when weight is less than or equal to zero' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
      product_model = ProductModel.new(name: 'TV 32' , weight: 0 , width: 70 , height: 45 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
      # Act
      result = product_model.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when width is less than or equal to zero' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
      product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 0 , height: 45 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
      # Act
      result = product_model.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when height is less than or equal to zero' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
      product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 70 , height: -1 , 
                                        depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
      # Act
      result = product_model.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when depth is less than or equal to zero' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
      product_model = ProductModel.new(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                        depth: -1 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
      # Act
      result = product_model.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when sku is already in use' do
      # Arrange
      supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG Eletronicos LTDA', 
                                registration_number: '43447215000102', full_address: 'Av Doutor Arnaldo, 125',
                                city: 'São Paulo', state: 'SP', email: 'sac@lgeletronicos.com')
      first_product_model = ProductModel.create!(name: 'TV 32' , weight: 8000 , width: 70 , height: 45 , 
                                            depth: 10 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)
      second_product_model = ProductModel.new(name: 'SoundBar 7.1 Surround' , weight: 3000 , width: 80 , height: 15 , 
                                                  depth: 20 , sku: 'TV32-LG-XPT090569743' , supplier: supplier)                                     
      # Act
      result = second_product_model.valid?
      # Assert
      expect(result).to eq false
    end
  end
end
