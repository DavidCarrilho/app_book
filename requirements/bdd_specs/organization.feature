Feature: Estante de Livros Virtual
  Como um usuário do aplicativo
  Eu quero visualizar os livros na minha estante virtual
  Para que eu possa escolher o que ler a seguir

  Scenario: Visualizar a estante de livros
    Given que eu tenho livros salvos na minha estante virtual
    When eu abro o aplicativo
    Then eu devo ver os livros na minha estante virtual