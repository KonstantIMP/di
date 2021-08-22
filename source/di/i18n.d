/**
 * A library for i18n in D
 * Author: KonstantIMP <mihedovkos@gmail.com>
 * Date: 22 Aug 2021
 */
module di.i18n;

import std.json, std.file, std.exception;

/** 
 * An exception for I18n errors
 */
public class I18nException : Exception {
    /** 
     * Creates and throws new I18nException
     * Params:
     *   err = Error message for the exception
     */
    public this (string err) { super (err); }
}

/** 
 * Struct for locale description
 * To load locale use JSON file with the struct :
 * { "name" : "locale`s name", "tr" : [{"id" : "id for the text", "tr" : "translation for the id"}, ...] }
 */
private class Locale {
    ///> Locale`s name (like 'en')
    string name;
    ///> Loaded translations for this locale
    string [string] tr;

    /** 
     * Inits the locale (noname as default)
     */
    public this () { name = ""; }
}

/** 
 * Class for actual i18n
 */
public static class I18n {
    ///> List of the loaded locales
    private static Locale [] loadedLocales;
    ///> Currently used locale
    private static Locale currentLocale;
    
    /**
     * Inits the I18n module
     */
    public static this () {
        loadedLocales = new Locale[0];
        currentLocale = null;
    }

    /** 
     * Loads locale from JSON file
     * Params:
     *   path = Path to the JSON locale
     * Throws:
     *   FileException if the file doesn`t exsists
     *   I18nException if was given incorrect locale file
     */
    public static void loadLocale (string path) {
        loadLocale (cast(ubyte [])read (path));
    }

    /** 
     * Loads locale from data
     * Params:
     *   data = Array for loading
     * Throws:
     *   I18nException if was given incorrect locale file
     *   JSONException if was given incorrect locale file
     */
    public static void loadLocale (ubyte [] data) {
        import std.conv : to;

        JSONValue lj = parseJSON (to!string(data));

        Locale ll = new Locale(); ll.name = lj["name"].str();

        foreach (tr; lj["tr"].array) {
            ll.tr[tr["id"].str()] = tr["tr"].str();
        }
        
        loadedLocales ~= ll;
    }
}
