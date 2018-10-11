#language:pt

Funcionalidade: Cadastro 
	Sendo uma aplicação que recebeu dados do usuário
	Posso solicitar uma requisição do tipo POST
	Para que os dados deste usuário sejam de fato cadastados no sistema

    @post_200
	Cenário: Cadastro simplificado

        Dado que o usuário informou os seguintes dados:
            | name      | Albert                    |
            | email     | albert.testeapi@teste.com |
            | password  | 123456                    |
        Quando eu faço uma solicitação POST para o serviço user
        Então o código de resposta HTTP deve ser igual a "200"
        E no corpo da resposta devo ver o ID do usuário

    #Outline (Este cenário é o outline em inglês - para poder usar uma lista de massa de teste)
    @tentativa_cadastro
    Esquema do Cenario: Campos não enviados
     
        Dado que o usuário informou os seguintes dados:
            | name     | <name>        |
            | email    | <email>       |
            | password | <password>    |
        Quando eu faço uma solicitação POST para o serviço user
        Então o código de resposta HTTP deve ser igual a "<status_code>"
        E no corpo da resposta devo ver uma mensagem "<message>"
    
    Exemplos:
      | name   | email                     | password | status_code | message               |
      |        | albert.testeapi@teste.com | 123456   | 409         | Name is required.     |
      | Albert |                           | 123456   | 409         | Email is required.    |
      | Albert | albert.testeapi@teste.com |          | 409         | Password is required. |