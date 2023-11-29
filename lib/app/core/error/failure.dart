class Failure implements Exception {
  Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  ServerFailure()
      : super(
          'Ocorreu um erro inesperado. Tente novamente mais tarde.',
        );
}

class TimeOutFailure extends Failure {
  TimeOutFailure()
      : super(
          'Tempo de requisição excedido. Tente novamente mais tarde.',
        );
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure()
      : super(
          'Você está sem conexão. Verifique a sua internet.',
        );
}

class JsonParsingFailure extends Failure {
  JsonParsingFailure()
      : super(
          'Erro ao tentar converter os dados json.',
        );
}

class AdapterParsingFailure extends Failure {
  AdapterParsingFailure()
      : super(
          'Erro ao tentar converter o obejeto em Adapter.',
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({
    String message = 'Não encontrado',
  }) : super(message);
}
