public interface Application.LocalStorageInterface : PersistentStorageInterface {
    public abstract void add (string key, string value);
    public abstract string get (string key);
    public abstract void delete (string key);
}