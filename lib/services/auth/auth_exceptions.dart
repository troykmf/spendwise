// login exception

class UserNotLoggedInAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register exception

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// unknown exception

class GenericAuthException implements Exception {}
