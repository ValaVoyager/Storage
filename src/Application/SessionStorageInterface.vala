public interface Application.SessionStorageInterface : VolatileStorageInterface {
    public abstract void add (string key, string value);
    public abstract string get (string key);
    public abstract void delete (string key);
}