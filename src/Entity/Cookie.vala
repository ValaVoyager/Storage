using Enum;

public class Entity.Cookie {
    private string name { get; set; }
    private string value { private get; private set; }
    private string domain { get; set; }
    private string path { get; set; }
    private int64? expiration { get; set; }
    private long size { get; set; }
    private SitePolicyEnum sameSite { get; set; }
    private int64? lastAccess { get; set; }
    private int64 createdOn { get; set; }

    public Cookie (string name,
                   string value,
                   string domain,
                   string? path,
                   int64? expiration,
                   SitePolicyEnum? sameSite,
                   int64? lastAccess,
                   int64? createdOn
    ) {
        this.name = name;
        this.value = value;
        this.domain = domain;
        this.path = path ?? "/";
        this.expiration = expiration;
        this.size = this.value.length; // May be useless
        this.sameSite = sameSite ?? SitePolicyEnum.STRICT;
        this.lastAccess = lastAccess;
        this.createdOn = createdOn ?? new DateTime.now ().to_unix ();
    }

    public string getValue () {
        this.lastAccess = new DateTime.now ().to_unix ();
        return this.value;
    }

    public void setValue (string value) {
        this.value = value;
        this.size = this.value.length;
    }

    public string toJson () {
        var builder = new Json.Builder ();

        builder.begin_object ();
        builder.set_member_name ("name");
        builder.add_string_value (this.name);
        builder.set_member_name ("value");
        builder.add_string_value (this.value);
        builder.set_member_name ("domain");
        builder.add_string_value (this.domain);
        builder.set_member_name ("path");
        builder.add_string_value (this.path);
        builder.set_member_name ("expiration");
        if (this.expiration == null) builder.add_null_value ();
        else builder.add_int_value (this.expiration);
        builder.set_member_name ("sameSite");
        switch (this.sameSite) {
            case SitePolicyEnum.STRICT:
                builder.add_string_value ("STRICT");
                break;
            case SitePolicyEnum.LAX:
                builder.add_string_value ("LAX");
                break;
            case SitePolicyEnum.NONE:
                builder.add_string_value ("NONE");
                break;
        }
        builder.set_member_name ("lastAccess");
        if (this.lastAccess == null) builder.add_null_value ();
        else builder.add_int_value (this.lastAccess);
        builder.set_member_name ("createdOn");
        builder.add_int_value (this.createdOn);
        builder.end_object ();

        Json.Generator generator = new Json.Generator ();
        Json.Node root = builder.get_root ();
        generator.set_root (root);

        return generator.to_data (null);
    }

    public static Cookie fromJson (string json) {
        var parser = new Json.Parser ();
        parser.load_from_data (json);

        var root = parser.get_root ();
        var obj = root.get_object ();

        var name = obj.get_string_member ("name");
        var value = obj.get_string_member ("value");
        var domain = obj.get_string_member ("domain");
        var path = obj.get_string_member ("path");
        var expiration = obj.get_int_member ("expiration");
        var sameSiteStr = obj.get_string_member ("sameSite");
        SitePolicyEnum? sameSite = null;
        switch (sameSiteStr) {
            case "STRICT":
                sameSite = SitePolicyEnum.STRICT;
                break;
            case "LAX":
                sameSite = SitePolicyEnum.LAX;
                break;
            case "NONE":
                sameSite = SitePolicyEnum.NONE;
                break;
        }
        var lastAccess = obj.get_int_member ("lastAccess");
        var createdOn = obj.get_int_member ("createdOn");

        return new Cookie (name, value, domain, path, expiration, sameSite, lastAccess, createdOn);
    }

    public void printCookie () {
        print ("Name: " + this.name + "\n");
        print ("Value: " + this.value + "\n");
        print ("Domain: " + this.domain + "\n");
        print ("Path: " + this.path + "\n");

        print ("Expiration: ");
        if (this.expiration == null) print("\033[1mnull\033[0m\n");
        else print (this.expiration.to_string () + "\n");

        print ("Size: " + this.size.to_string () + "\n");

        print ("LastAccess: ");
        if (this.lastAccess == null) print("\033[1mnull\033[0m\n");
        else print (this.lastAccess.to_string () + "\n");

        print ("CreatedOn: " + this.createdOn.to_string ());
    }
}

