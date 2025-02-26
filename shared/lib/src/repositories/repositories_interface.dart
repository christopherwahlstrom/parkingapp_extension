abstract class RepositoryInterface<T> {
  Future<T> create(T entity);
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<void> update(String id, T entity);
  Future<void> delete(String id);
}