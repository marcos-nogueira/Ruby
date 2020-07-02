# README

Esse projeto foi desenvolvido com base no Desafio para desenvolvedor - Processo de recrutamento SkyHub B2W.

Para esse projetos foi escolhido o framework Ruby on Rails e o banco de dados MongoDB
pela praticidade e familiaridade.


Especificações

* Ruby version 2.5.1

* Para instalar as dependencias do sistema execute na raiz do projeto execute o comando: bin/setup

* Para Popular a Base execute na raiz do projeto execute o comando:   rails dev:setup

* Para executar os testes execute na raiz do projeto o camando: rspec
* As requisições via Postman estão disponivel no arquivo Desafio.postman_collection.json na raiz do projeto


Sobre o Desafio

Desenvolver uma API de Cadastro de produtos e pedidos para a loja do “seu” Manuel.

Foi criado os recursos:

products

Responsável por cadastrar, consultar, atualizar e deletar produtos.

Cada produto possui um código identificador único SKU, e possui os atributos:

 nome, descrição preço e preço_promocional e quantidade.

orders

Responsável por cadastrar, consultar, atualizar e *deletar pedidos.

Cada pedido é identificado pelo code e possui os seguintes campos:

data, custumer, items, shiooing_cost e total

No método PUT é permitido apenas atualizar o status do pedido.

*melhorias a serem aplicadas

Não permitir o delete de pedidos e validar status finalizadores

reports

Responsável por retornar um relatório de ticket médio por um período especificado.




