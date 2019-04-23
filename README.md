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
O modelo de dados desta API é composto de: <br/>
* tb_account <br/>
  Possui informações da conta e o saldo desta (este projeto não está utilizando [CQRS](https://martinfowler.com/bliki/CQRS.html)) <br/>
* tb_movements <br/>
  Possui todos os fatos ocorridos sobre o saldo de uma conta <br/>
* tb_transfer <br/>
  Possui as transferências para outros bancos (ted) com as informações do favorecido <br/>
* tb_user <br/>
  Possui as credenciais de acesso a API <br/>
<img width="496" alt="Screen Shot 2019-04-16 at 06 15 22" src="https://user-images.githubusercontent.com/4596229/56197387-1aaf9000-600f-11e9-80bb-16d33c43f65e.png">

## API REST
Para expor nossos serviços utilizamos o estilo arquitetural [REST](https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm). Para proteção de nossa API utilizamos autenticação via JWT, o token terá validade de 1 hora. 

Credenciais de acesso:<br/>
   username: admin <br/>
   password: admin <br/>
   
API disponível em: **http://52.204.222.61:8080/** <br/>
Documentação dispnível em: **https://documenter.getpostman.com/view/3564642/S1ENzzQY** <br/>
   
* Endpoints
   * (Post) [/auth/token](http://52.204.222.61:8080/auth/token) <br/>
     Provém recurso responsável pela autenticação <br/>
     <img width="411" alt="Screen Shot 2019-04-16 at 07 51 31" src="https://user-images.githubusercontent.com/4596229/56204400-b9db8400-601d-11e9-9afa-30db03161ad4.png">

   * (Post) [/api/accounts](http://52.204.222.61:8080/api/accounts) <br/>
     Provém recurso responsável pela criação de uma conta <br/>
     <img width="412" alt="Screen Shot 2019-04-16 at 07 51 57" src="https://user-images.githubusercontent.com/4596229/56204381-ab8d6800-601d-11e9-9505-af7f6a663586.png">

   * (Get) [/api/accounts/{account_number}/balance](http://52.204.222.61:8080/api/accounts/41817987/balance) <br/>
     Provém recurso responsável por retornar o saldo para uma determinada conta <br/>
     <img width="412" alt="Screen Shot 2019-04-16 at 07 54 40" src="https://user-images.githubusercontent.com/4596229/56204341-94e71100-601d-11e9-9cee-a3176106283d.png">

   * (Post) [/api/transactions](http://52.204.222.61:8080/api/transactions) <br/>
     Provém recurso responsável por executar débito(operation_type=D) e crédito(operation_type=C) em uma determinada conta <br/>
     <img width="412" alt="Screen Shot 2019-04-16 at 07 54 59" src="https://user-images.githubusercontent.com/4596229/56204307-83056e00-601d-11e9-9f53-5ba6ed131376.png">

   * (Post) [/api/transactions/transfer](http://52.204.222.61:8080/api/transactions/transfer) <br/>
     Provém recurso responsável por realizar transferência(transações entre contas do banco 875) e ted(transações tendo a conta favorecida em outro banco) <br/>
     <img width="412" alt="Screen Shot 2019-04-16 at 07 55 37" src="https://user-images.githubusercontent.com/4596229/56204270-69fcbd00-601d-11e9-9dc9-d9cef6b55f8f.png">

   * (Get) [/api/reports/transaction](http://52.204.222.61:8080/api/reports/transaction?filter=day&value=2019-04-07&type=synthetic) <br/>
     Provém recurso responsável por extração de relatórios <br/>
     <img width="413" alt="Screen Shot 2019-04-16 at 07 56 13" src="https://user-images.githubusercontent.com/4596229/56204238-57828380-601d-11e9-8f6f-b9bf7f3ac2ce.png">

## Execução
Para realizar o empacotamento e o deployment da aplicação foi utilizado [Distillery](https://hexdocs.pm/distillery/home.html).

Executando via Docker Compose:
```
      git clone github.com:robsonhs/api-bankink.git
      cd api-bankink
      docker-compose -f docker-compose.yml up -d
```
Executando na IDE:
```
      git clone github.com:robsonhs/api-bankink.git
      cd api-bankink
      mix deps.clean --all
      mix deps.get
      mix deps.compile --all
      docker image build -t app-api-banking /bd/
      docker container run -e POSTGRES_DB=api_banking -e POSTGRES_USER=apibanking -e POSTGRES_PASSWORD=apibanking -p 5432:5432 -d api-banking-postgres
      MIX_ENV=dev mix run --no-halt
```
