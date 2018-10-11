Dado("que o usuário esta autenticado") do |user|
    @result = HTTParty.post(
        'https://marktasks.herokuapp.com/api/login',
        headers: {'Content-Type' => 'application/json'},
        #rows_hash - converte para um hash do ruby e usa to_json para já converter para json
        body: user.rows_hash.to_json
    )
    #imprimindo o valor da variavel @token que criamos que recebe o valor do response de @result (pode colocar o puts para debugar o que esta trazendo na tela)
    #parsed_response - converte o resultado HTTP Response que é um Json para um hash do ruby para poder trabalhar com os dados do hash
    #puts @token = @result.parsed_response['data']
    @token = @result.parsed_response['data']
end
  
Dado("o usuário informou a seguinte tarefa") do |table|
    @task = table.rows_hash
    @task['tags'] = [] # colocando dentro da variavel task na posiçao ['tags'] que foi convertido para um hash do ruby um array vazio de tags
end
  
Dado("eu quero taguear esta tarefa com:") do |table|
    #criando um foreach para a table percorrendo ela e inserindo dentro do objeto "tasks posição  ['tags']  que era um array vazio de tags, cada tag encontrada .push(t['tag']) - inseriu cada "tag" recebida da massa de teste do cucumber "exemplos"
    #puts table.hashes
    table.hashes.each do |t|
        #puts t['tag']
        @task['tags'].push(t['tag'])
    end
    #puts @task
end
  
Quando("eu faço uma solicitação POST para o serviço tasks") do
    @result = HTTParty.post(
        'https://marktasks.herokuapp.com/api/tasks',
        #mandando o header com o userId e Token
        headers: {
            'Content-Type' => 'application/json',
            'X-User-id' => @token['userId'], #chamando a variavel @token posição ['userId'] que possui o retorno do login aonde foi gerado o userId e token
            'X-Auth-Token' => @token['authToken'] #chamando a variavel @token posição ['authToken'] que possui o retorno do login aonde foi gerado o userId e token
        },
        #mandando o body convertido para json
        body: @task.to_json
    )
end
  
Então("esta tarefa deve ser cadastrada com sucesso") do
    #imprimindo o valor da variavel @result que possui o parsed_response do post de task - (pode colocar o puts para debugar o que esta trazendo na tela)
    #puts @result.parsed_response
    expect(@result.parsed_response['message']).to eql 'The task has been created.'
end