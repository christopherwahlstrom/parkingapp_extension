abstract interface class RepositoryInterface<T> {
  Future<T> create(T item);
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<void> update(String id, T item);
  Future<void> delete(String id);
}