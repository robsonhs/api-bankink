# API BANKING


## Aplicação
Este aplicativo foi desenvolvido utilizando a linguagem funcional [Elixir](https://elixir-lang.org/) com o objetivo de prover serviços financeiros por meio de uma API REST. Para desenvolvimento deste aplicativo foi utilizado alguns dos principais modulos do Elixir como [Plug](https://hexdocs.pm/plug/readme.html), [Ecto](https://hexdocs.pm/ecto/Ecto.html) e [Guardian](https://hexdocs.pm/guardian/Guardian.html). Para armazenamento de dados foi utilizado [PostgreSQL](https://www.postgresql.org/).

## Estrutura
O aplicativo foi estruturado de modo a segregar os módulos em router, controller, model e repo.
* Routers
    * ApiBanking.Router <br/>
      Disponibiliza rotas de autenticação e de recursos da API
        ```
        forward "/auth/token", to: ApiBanking.Router.Authentication
        forward "/api", to: ApiBanking.Router.Authorization 
        ```
      - ApiBanking.Router.Authentication <br/>
        Disponibiliza recurso responsável pela autenticação 
          ```
          post "/"
          ```
      - ApiBanking.Router.Authorization <br/>
        Provém autorização a partir de um token JWT e disponibiliza as rotas para os resources da api
          ```
          forward "/accounts", to: ApiBanking.Router.Account
          forward "/transactions", to: ApiBanking.Router.Transaction
          forward "/reports", to: ApiBanking.Router.Report
          ```
         * ApiBanking.Router.Account <br/>
            Disponibiliza recursos referentes a conta
            ```
            get "/:account/balance"
            post "/"
            ```
         * ApiBanking.Router.Transaction
           Disponibiliza recursos referentes a movimentações (débito e crédito) sobre uma conta
            ```
            post "/"
            post "/transfer"
            ```
         * ApiBanking.Router.Report
           Disponibiliza recursos referentes a relatórios gerenciais
            ```
            get "/transaction"
            ```
* Controller <br/>
  Os módulos controller são responsáveis pela regra de negócio da API
  * ApiBanking.Controller.User <br/>
    Responsável em prover a autenticação, valida as credenciais e gera um token de acesso 
  * ApiBanking.Controller.Account <br/>
    Responsável em prover o cadastro de conta e a consulta de saldo
  * ApiBanking.Controller.DebitCredit <br/>
    Responsável em prover as operações de débito e crédito (Saque/Estorno)
  * ApiBanking.Controller.Transfer <br/>
    Responsável em prover transferência (mesmo banco) e ted (bancos diferentes)
  * ApiBanking.Controller.Report <br/>
    Responsável em prover relatórios das transações realizadas
  
* Repo <br/>
  Os módulos repo são responsáveis pela execução das operações sobre o banco de dados 
  * ApiBanking.Repo.User <br/>
    Responsável em executar sql's sobre o usuario
  * ApiBanking.Repo.DebitCredit <br/>
    Responsável em executar sql's de débito e crédito sobre uma conta
  * ApiBanking.Repo.Transfer <br/>
    Responsável em executar sql's de transferência e ted sobre uma conta
  * ApiBanking.Repo.Report <br/>
    Responsável em executar sql's para extração de relatórios sobre as movimentações de uma conta
  
    <img width="670" alt="Screen Shot 2019-04-15 at 22 39 53" src="https://user-images.githubusercontent.com/4596229/56191048-f6998200-6001-11e9-98c5-04b0595c95e3.png">

## Modelo de dados
O modelo de dados desta API é composto de:
   * tb_acount
     
   * tb_movements
   
   * tb_transfer
   
   * tb_user
   
