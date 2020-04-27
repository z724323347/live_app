import 'dart:async';
import 'dart:io';

/// socket
class SocketEvent {
  ///
  final String category;

  ///
  final String issue;

  ///
  final String result;

  SocketEvent({this.category, this.issue, this.result});
}
