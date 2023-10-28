class ServerException implements Exception {}

class EmptyCashException implements Exception {}

class WrongDataException implements Exception {
  WrongDataException(this.message);

  final String message;
}

class UserNameException implements Exception {}

class BlockedException implements Exception {}
