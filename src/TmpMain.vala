using Entity;

int main (string[] args) {
    var myCookie = new Cookie (
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
    myCookie.printCookie ();
    print ("\n\n");

    print ("Encoding as JSON...\n");
    string jsonCookie = myCookie.toJson ();
    print (jsonCookie);
    print ("\nDone!\n\n");

    print ("Reading from a json string: ...\n");
    string json = """{"name": "other-cookie", "value": "this is another cookie!", "domain": "dunno", "path": "/", "expiration": null, "sameSite": "LAX", "lastAccess": 1725054119, "createdOn": 1725054110}""";
    print (json + "\n");
    var anotherCookie = Cookie.fromJson (json);
    print ("\n");
    anotherCookie.printCookie ();
    print("\n\n");

    print ("All done!\n\n");

    return 0;
}
