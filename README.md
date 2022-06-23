# Sistema Warehouse :computer:

## Descrição do projeto:


Representa uma aplicação dentro do contexto de um e-commerce, responsável pela gestão de galpões e do estoque de cada galpão. Os galpões estão espalhados por vários endereços no país e são responsáveis por receber produtos novos comprados pela empresa, manter os dados de estoque atualizados e registrar a saída de produtos. Os produtos são comprados de fornecedores e a entrada dos produtos está sempre vinculada a um pedido. 

## Pré-requisitos:

 * Ruby 3.1.0
 * Rails 7.0.3
* sqlite 3 1.4
 
### Gems Complementares
#### Testes

  * RSpec  https://rubygems.org/gems/rspec/versions/3.10.0
  * Capybara  https://rubygems.org/gems/capybara/versions/3.35.3

                                          
#### Autorização/Autenticação

  * Devise  https://github.com/heartcombo/devise#getting-started
 
 ## Instruções

Clone o projeto:

```sh
git@github.com:AraceleSouza/sistema-warehouse.git
```

Instalação e execução:

```sh
bundle install               => instalar dependencias do projeto (o ruby 3.1.0 deve estar instalado)

bin/rails db:prepare db:seed => preparar e popular banco de dados

bundle exec rspec            => rodar testes

rails server                 => rodar servidor
```

Com o servidor rodando acesse [localhost](http://localhost:3000/)

## Funcionalidades:

####  Agendamento de recebimento
- O sistema permite inserir informações como local e data de execução da operação, favorecendo o cálculo dos recursos e do tempo necessários.

####  Separação
 - Com as informações sempre atualizadas no sistema, o controle e a identificação de localização de cada item solicitado, fica mais assertivo de acordo com a disponibilidade informada pela equipe.
 
####  Expedição
- A partir das informações fornecidas pelo sistema, a conferência dos itens em área pronta para o embarque e envio aos clientes se torna mais rápida e eficiente.

#### Transferências
-  Ao gerir vários galpões com esse sistema, as transferências entre estoques diferentes, inclusive em unidades e filiais, ficam mais assertivas e produtivas, evitando erros e retrabalhos.


## Usuários


####  Não Autenticado

- Possui apenas acesso a listagem de galpões cadastrados no sistema.

#### Autenticado

- Possui acesso a todas as informações relacionadas aos galpões,  pedidos e produtos.

- Consegue criar ou editar um pedido.

- Acesso a listagem  e informações detalhadas de fornecedores. 
 
- Cadastra  e edita um fornecedor.
 
-  Vê itens disponíveis no estoque e também pode dar baixa em itens do estoque. 
