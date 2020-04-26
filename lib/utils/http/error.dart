class MessageError with Exception {
  final String message;

  final int code;

  MessageError(this.message, { this.code });

  @override
  String toString() {
    return this.message;
  }
}