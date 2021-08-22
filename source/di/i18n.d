/**
 * A library for i18n in D
 * Author: KonstantIMP <mihedovkos@gmail.com>
 * Date: 22 Aug 2021
 */
module di.i18n;

import std.json, std.file, std.stdio, std.exception;

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
}
