using Domain.Enum;

public class Domain.Entity.Cookie {
    private string name { get; set; }
    private string value;
    private string domain { get; set; }
    private string path { get; set; }
    private int64? expiration { get; set; }
    private long size { get; set; }
    private SitePolicyEnum same_site { get; set; }
    private int64? last_access { get; set; }
    private int64 created_on { get; set; }

    public Cookie (string name,
                   string value,
                   string domain,
                   string? path,
                   int64? expiration,
                   SitePolicyEnum? same_site,
                   int64? last_access,
                   int64? created_on
    ) {
        this.name = name;
        this.value = value;
        this.domain = domain;
        this.path = path ?? "/";
        this.expiration = expiration;
        this.size = this.value.length; // May be useless
        this.same_site = same_site ?? SitePolicyEnum.STRICT;
        this.last_access = last_access;
        this.created_on = created_on ?? new DateTime.now ().to_unix ();
    }

    public string get_value () {
        this.last_access = new DateTime.now ().to_unix ();
        return this.value;
    }

    public void set_value (string value) {
        this.value = value;
        this.size = this.value.length;
    }

    public string to_json () {
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
        switch (this.same_site) {
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
        if (this.last_access == null) builder.add_null_value ();
        else builder.add_int_value (this.last_access);
        builder.set_member_name ("createdOn");
        builder.add_int_value (this.created_on);
        builder.end_object ();

        Json.Generator generator = new Json.Generator ();
        Json.Node root = builder.get_root ();
        generator.set_root (root);

        return generator.to_data (null);
    }

    public static Cookie from_json (string json) throws GLib.Error {
        var parser = new Json.Parser ();
        parser.load_from_data (json);

        var root = parser.get_root ();
        var obj = root.get_object ();

        var name = obj.get_string_member ("name");
        var value = obj.get_string_member ("value");
        var domain = obj.get_string_member ("domain");
        var path = obj.get_string_member ("path");
        var expiration = obj.get_int_member ("expiration");
        var same_site_str = obj.get_string_member ("same_site");
        SitePolicyEnum? same_site = null;
        switch (same_site_str) {
            case "STRICT":
                same_site = SitePolicyEnum.STRICT;
                break;
            case "LAX":
                same_site = SitePolicyEnum.LAX;
                break;
            case "NONE":
                same_site = SitePolicyEnum.NONE;
                break;
        }
        var last_access = obj.get_int_member ("last_access");
        var created_on = obj.get_int_member ("created_on");

        return new Cookie (name, value, domain, path, expiration, same_site, last_access, created_on);
    }

    public void print_cookie () {
        print ("Name: " + this.name + "\n");
        print ("Value: " + this.value + "\n");
        print ("Domain: " + this.domain + "\n");
        print ("Path: " + this.path + "\n");

        print ("Expiration: ");
        if (this.expiration == null) print ("\033[1mnull\033[0m\n");
        else print (this.expiration.to_string () + "\n");

        print ("Size: " + this.size.to_string () + "\n");

        print ("LastAccess: ");
        if (this.last_access == null) print ("\033[1mnull\033[0m\n");
        else print (this.last_access.to_string () + "\n");

        print ("CreatedOn: " + this.created_on.to_string ());
    }
}

