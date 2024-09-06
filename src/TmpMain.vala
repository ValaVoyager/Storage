using Domain.Entity;

int main (string[] args) {
    try {
        var my_cookie = new Cookie (
            "my-cookie",
            "cookie value!",
            "https://browser.valavoyag.er",
            null,
            null,
            null,
            null,
            null
        );

        print ("Cookie created!\n\n");
        my_cookie.print_cookie ();
        print ("\n\n");

        print ("Encoding as JSON...\n");
        string json_cookie = my_cookie.to_json ();
        print (json_cookie);
        print ("\nDone!\n\n");

        print ("Reading from a json string: ...\n");
        string json = """{"name": "other-cookie", "value": "this is another cookie!", "domain": "dunno", "path": "/", "expiration": null, "same_site": "LAX", "last_access": 1725054119, "created_on": 1725054110}""";
        print (json + "\n");
        var another_cookie = Cookie.from_json (json);
        print ("\n");
        another_cookie.print_cookie ();
        print ("\n\n");

        print ("All done!\n\n");
    } catch (GLib.Error error) {
        return error.code;
    }
    

    return 0;
}
