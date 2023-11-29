Feature: Download e Armazenamento de Livros
  Como um usuário do aplicativo
  Eu quero baixar livros
  Para que eu possa lê-los offline

  Scenario: Baixar um livro
    Given que eu estou na página de detalhes de um livro
    When eu clico no botão de download
    Then o livro deve ser baixado e salvo no meu dispositivo