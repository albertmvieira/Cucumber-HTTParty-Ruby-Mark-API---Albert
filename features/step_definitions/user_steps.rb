Dado("que o usuário informou os seguintes dados:") do |table|
    # comando .rows_hash => transforma a tabela em um objeto hash do ruby (igual array)
    puts @user = table.rows_hash

    # comando HTTParty.get envia um get para API (Neste caso passando para resetar o usuario pela API criada para facilitar os testes)
    HTTParty.get("https://marktasks.herokuapp.com/api/reset/#{@user['email']}?clean=full",)
end
  
Quando("eu faço uma solicitação POST para o serviço user") do
    #HTTParty.post Recurso do HTTParty para enviar um post (seguindo a estrutura:: URL/Header/Body)
    @result = HTTParty.post(
        'https://marktasks.herokuapp.com/api/user', 
        headers: {'Content-Type' => 'application/json'},
        body: @user.to_json, # .to_json convertendo variável @user que é um hash do ruby para json
    )
end
  
Então("o código de resposta HTTP deve ser igual a {string}") do |status_code|
    #response.code - pega o código de respota
    expect(@result.response.code).to eql status_code
end
  
Então("no corpo da resposta devo ver o ID do usuário") do
    #puts @result.class - conseguimos pegar o tipo que a variavel result assumiu. Neste caso um HTTP Response que é um Json
    #parsed_response - converte o resultado HTTP Response que é um Json para um hash do ruby para poder trabalhar com os dados do hash
    puts @result.parsed_response
    #have_key - comando httparty para verificar se dentro do objeto data contem a chave (neste caso 'id')
    expect(@result.parsed_response['data']).to have_key('id')
    #validando se o tamanho do id é igual a 17 caracteres
    expect(@result.parsed_response['data']['id'].length).to eql 17
end
  
Então("no corpo da resposta devo ver uma mensagem {string}") do |message|
    #imprimir a variavel @result ja convertendo para hash do ruby - Desta forma é possível descobrir em qual objeto retorna a mensagem
    puts @result.parsed_response['message']
    #Após pegar o objeto só validar:
    expect(@result.parsed_response['message']).to eql message
end

#JSON (Java Script Object Notation) (Nativo somente dentro do javascript)
#por isso precisamos converter para hash do ruby