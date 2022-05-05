class WarehousesController < ApplicationController
    def show
        id = params[:id]
        @warehouse = Warehouse.find(id)
    end
    
    def new
    end

    def create
      # Aqui dentro que nós vamos:
      # 1- Receber os dados enviados
      # 2- Criar um novo galpão no banco de dados
      warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
      warehouse =  Warehouse.new(warehouse_params)
      warehouse.save()
      # 3 - Redirecionar para tela inicial 
      redirect_to root_path
    end
end