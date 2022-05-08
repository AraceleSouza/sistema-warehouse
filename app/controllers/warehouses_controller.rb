class WarehousesController < ApplicationController
    def show
        id = params[:id]
        @warehouse = Warehouse.find(id)
    end
    
    def new
      @warehouse = Warehouse.new
    end

    def create
      # Aqui dentro que nós vamos:
      # 1- Receber os dados enviados
      # 2- Criar um novo galpão no banco de dados
      warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, 
                                                           :cep, :area) # Strong Parameters
      @warehouse = Warehouse.new(warehouse_params) 
      if @warehouse.save()
        redirect_to root_path, notice: "Galpão cadastrado com sucesso."
      else
        flash.now[:notice] = "Galpão não cadastrado."
        render 'new'
      end
      # 3 - Redirecionar para tela inicial 
      #flash[:notice] = "Galpão cadastrado com sucesso."
     
    end
end