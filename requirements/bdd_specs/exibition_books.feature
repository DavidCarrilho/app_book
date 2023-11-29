Feature: Exibição de Livros
  Como um usuário do aplicativo
  Eu quero ler um livro
  Para que eu possa desfrutar da leitura

  Scenario: Ler um livro
    Given que eu tenho um livro baixado no meu dispositivo
    When eu clico no livro na minha estante virtual
    Then o livro deve ser aberto no leitor de ebooks integrado