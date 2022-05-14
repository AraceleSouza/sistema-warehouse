require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
        # Act
        result = supplier.valid?
        # Assert
        expect(result).to eq false 
      end

      it 'false when brand_name is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: '', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end

      it 'false when registration_number is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end

      it 'false when full_address is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: '', city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end

      it 'false when city is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: '', state:'SP', email: 'tech_vision@gmail.com')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end

      it 'false when state is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'', email: 'tech_vision@gmail.com')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end

      it 'false when email is empty' do
          # Arrange
          supplier = Supplier.new(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', registration_number: '43447216000102', 
                      full_address: 'Av das Flores, 500', city: 'Cajamar', state:'SP', email: '')
          # Act
          result = supplier.valid?
          # Assert
          expect(result).to eq false
      end
    end

    it 'false when registration_number is already in use' do
      # Arrange
      first_supplier = Supplier.create(corporate_name: 'World Technology Vision LTDA', brand_name: 'TECH VISION', 
                                        registration_number: '43447216000102', full_address: 'Av das Flores, 500', 
                                        city: 'Cajamar', state:'SP', email: 'tech_vision@gmail.com')

      second_supplier = Supplier.new(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', 
                                    registration_number: '43447216000102', full_address: 'Av das cerejeiras, 41', 
                                    city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')                                        
      # Act
      result = second_supplier.valid?
      # Assert
      expect(result).to eq false
    end

    it 'false when registration_number is invalid' do
      # Arrange
      supplier = Supplier.new(corporate_name: 'Mundo Eletrônicos LTDA', brand_name: 'Mundo Eletronicos', 
                              registration_number: '436000102', full_address: 'Av das cerejeiras, 41', 
                              city: 'Salvador', state:'BA', email: 'eletronicos@gmail.com')
      # Act
      result = supplier.valid?
      # Assert
      expect(result).to eq false
    end
  end
end
