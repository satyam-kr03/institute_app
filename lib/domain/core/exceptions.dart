class NotAuthenticatedException implements Exception {
  NotAuthenticatedException(this.message);
  final String message;
}
