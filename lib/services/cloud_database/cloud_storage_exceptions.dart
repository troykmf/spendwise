class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C in CRUD
class CouldNotCreateException extends CloudStorageException {}

// R in CRUD
class CouldNotGetAllDataException extends CloudStorageException {}

// U in CRUD
class CouldNotUpdateDataException extends CloudStorageException {}

// D in CRUD
class CouldNotDeleteDataException extends CloudStorageException {}
