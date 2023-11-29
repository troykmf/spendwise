class BudgetStorageException implements Exception {
  const BudgetStorageException();
}

// C in CRUD
class CouldNotCreateBudgetException extends BudgetStorageException {}

// R in CRUD
class CouldNotGetAllBudgetDataException extends BudgetStorageException {}

// U in CRUD
class CouldNotUpdateBudgetDataException extends BudgetStorageException {}

// D in CRUD
class CouldNotDeleteBudgetDataException extends BudgetStorageException {}
