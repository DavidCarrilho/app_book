Feature: Favoritos
  Como um usuário do aplicativo
  Eu quero marcar um livro como favorito
  Para que eu possa acessá-lo rapidamente

  Scenario: Marcar um livro como favorito
    Given que eu estou na página de detalhes de um livro
    When eu clico no botão de favorito
    Then o livro deve ser adicionado à minha lista de favoritos