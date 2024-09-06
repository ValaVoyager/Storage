using Domain.Entity;

public interface Application.CookieStorageInterface : PersistentStorageInterface {
    public abstract void add_cookie (Cookie cookie);
    public abstract Cookie get_cookie (string cookie_name);
    public abstract void delete_cookie (string cookie_name);
}