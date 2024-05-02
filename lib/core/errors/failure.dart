abstract class Failure {
  const Failure(this.message);
  final String message;
}

class ApiFailure extends Failure {
  const ApiFailure(super.message);
}
