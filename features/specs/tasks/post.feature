#language:pt

Funcionalidade: Cadastrar tarefas
    Sendo uma aplicação cliente
    Posso solicitar requisições POST para os serviços tasks
    Para que as tarefas do usuário sejam cadastradas no sistema

    #Utilizando contexto 
    Contexto: Autenticação
        Dado que o usuário esta autenticado
            |email      |albert.testeapi30@teste.com|
            |password   |123456                     |

    @post_task
    Cenario: Nova tarefa

        E o usuário informou a seguinte tarefa
            | title     | Ler um livro de Javascript   |
            | dueDate   | 31/05/2018                   |
            | status    | false                        |
        E eu quero taguear esta tarefa com:
            | tag           |
            | javascript    |
            | livro         |
            | leitura       |
            | estudar       |
        Quando eu faço uma solicitação POST para o serviço tasks
        Então o código de resposta HTTP deve ser igual a "200"
        E esta tarefa deve ser cadastrada com sucesso