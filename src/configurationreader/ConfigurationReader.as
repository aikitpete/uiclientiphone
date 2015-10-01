/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package configurationreader {

import flash.events.*;

import utils.XMLLoader;

/**
 * Class for reading configuration
 */
public class ConfigurationReader {

    private static const CONFIG_FILE_PATH:String = "configuration/files/mainconfig.xml";

    private static var eventDispatcher:EventDispatcher;

    public static var iPhoneMode:String;
    public static var policyServerHost:String;
    public static var policyServerPort:Number;
    public static var uiServerHost:String;
    public static var uiServerPort:Number;

    //stored paths to configuration files
    private static var uiTriggersPath:String;
    private static var uiComponentsPath:String;
    private static var uiPropertiesPath:String;
    private static var uiModifiersPath:String;
    private static var defaultModelsPath:String;
    private static var defaultXMLsPath:String;

    //events configuration
    private static var uiTriggers:Configuration;
    //ui uicomponents.uicomponents configuration
    private static var uiComponents:Configuration;
    //property mapping configuration
    private static var uiProperties:Configuration;
    //uicomponents.modifiers configuration
    private static var uiModifiers:Configuration;
    //default models configuration
    private static var defaultModels:Configuration;
    //default XMLs configuration
    private static var defaultXMLs:Configuration;


    /**
     * Resets the configuration
     */
    public static function reset():void {

        eventDispatcher = new EventDispatcher();

        uiTriggers = new Configuration();
        uiComponents = new Configuration();
        uiProperties = new Configuration();
        uiModifiers = new Configuration();
        defaultModels = new Configuration();
        defaultXMLs = new Configuration();

    }

    /**
     * Initializes the configuration
     */
    public static function init():void {

        uiTriggers.addEventListener(Event.COMPLETE, loadedHandler);
        uiComponents.addEventListener(Event.COMPLETE, loadedHandler);
        uiProperties.addEventListener(Event.COMPLETE, loadedHandler);
        uiModifiers.addEventListener(Event.COMPLETE, loadedHandler);
        defaultModels.addEventListener(Event.COMPLETE, loadedHandler);
        defaultXMLs.addEventListener(Event.COMPLETE, loadedHandler);

        XMLLoader.loadXML(CONFIG_FILE_PATH, processXML);
    }

    /**
     * Reads predefined XML
     * @param type type of XML
     * @param name of the XML
     * @param handler when the XML is read
     */
    public static function getDefaultXML(type:String, name:String, handler:Function):void {
        if (type == ObjectType.DEFAULT_XML) {
            XMLLoader.loadXML(defaultXMLs.getPathByClassName(name), handler);
        } else if (type == ObjectType.DEFAULT_MODEL) {
            XMLLoader.loadXML(defaultModels.getPathByClassName(name), handler);
        }
    }

    /**
     * Processes the main configuration file
     * @param xml
     */
    private static function processXML(xml:XML):void {

        iPhoneMode = xml.iphonemode.@value;
        policyServerHost = xml.policyserverhost.@value;
        policyServerPort = Number(xml.policyserverport.@value);
        uiServerHost = xml.uiserverhost.@value;
        uiServerPort = Number(xml.uiserverport.@value);

        uiTriggersPath = xml.uitriggerspath.@value;
        uiComponentsPath = xml.uicomponentspath.@value;
        uiPropertiesPath = xml.uipropertiespath.@value;
        uiModifiersPath = xml.uimodifierspath.@value;
        defaultModelsPath = xml.defaultmodelspath.@value;
        defaultXMLsPath = xml.defaultdocumentspath.@value;


        XMLLoader.loadXML(uiTriggersPath, uiTriggers.getXMLHandler());
        XMLLoader.loadXML(uiComponentsPath, uiComponents.getXMLHandler());
        XMLLoader.loadXML(uiPropertiesPath, uiProperties.getXMLHandler());
        XMLLoader.loadXML(uiModifiersPath, uiModifiers.getXMLHandler());
        XMLLoader.loadXML(defaultModelsPath, defaultModels.getXMLHandler());
        XMLLoader.loadXML(defaultXMLsPath, defaultXMLs.getXMLHandler());

    }

    /**
     * Function called when a configuration is loaded
     * @param event
     */
    private static function loadedHandler(event:Event):void {
        if (uiTriggers.getLoaded() == false) return;
        if (uiComponents.getLoaded() == false) return;
        if (uiProperties.getLoaded() == false) return;
        if (uiModifiers.getLoaded() == false) return;
        if (defaultModels.getLoaded() == false) return;
        if (defaultXMLs.getLoaded() == false) return;
        eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
    }

    /**
     * Gets full configuration including property mapping
     * @param name
     * @param type
     * @return
     */
    public static function getDetailedConfigurationByClassName(name:String, type:String):IClassConfiguration {
        var classConfig:IClassConfiguration;
        switch (type) {
            case ObjectType.COMPONENT:
                classConfig = uiComponents.getConfigurationByName(name);
                return classConfig;

            case ObjectType.PROPERTY:
                classConfig = uiProperties.getConfigurationByName(name);
                return classConfig;

            default:
                UIClient.debug("(ConfigurationReader) Unimplemented object type:" + type);
                return null

        }
    }

    public static function getPathByClassName(className:String, type:String):String {
        switch (type) {
            case ObjectType.TRIGGER:
                return uiTriggers.getPathByClassName(className);

            case ObjectType.MODIFIER:
                return uiModifiers.getPathByClassName(className);

            default:
                UIClient.debug("(ConfigurationReader) Unimplemented object type:" + type);
                return null;
        }
    }

    public static function hasEventListener(type:String):Boolean
    {
        return eventDispatcher.hasEventListener(type);
    }

    public static function willTrigger(type:String):Boolean
    {
        return eventDispatcher.willTrigger(type);
    }

    public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false):void
    {
        eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
    {
        eventDispatcher.removeEventListener(type, listener, useCapture);
    }

    public static function dispatchEvent(event:Event):Boolean
    {
        return eventDispatcher.dispatchEvent(event);
    }

    public static function toString():String {
        var ret:String = "Configuration:\n";
        ret = ret + "Actions file:\t\t\t" + uiTriggersPath + "\nComponents file:\t\t\t" + uiComponentsPath + "\nElements file:\t\t\t" +
              uiPropertiesPath + "\nModifiers file:\t\t\t" + uiModifiersPath + "\nDefault models path:\t\t\t" + defaultModelsPath +
              "\nDefault XMLs path:\t\t\t" + defaultXMLsPath + "\n";
        ret = ret + "**Triggers**\n" + uiTriggers.toString() + "\n";
        ret = ret + "**Components classes**\n" + uiComponents.toString() + "\n";
        ret = ret + "**Elements classes**\n" + uiProperties.toString() + "\n";
        ret = ret + "**Modifiers classes**\n" + uiModifiers.toString() + "\n";
        ret = ret + "**Models XMLs**\n" + uiProperties.toString() + "\n";
        ret = ret + "**Default XMLs**\n" + uiModifiers.toString() + "\n";
        return ret;
    }

}
}