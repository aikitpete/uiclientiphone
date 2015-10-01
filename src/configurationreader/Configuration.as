/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package configurationreader {

import flash.events.*;

/**
 * Main class for holding configuration
 */
public class Configuration implements IEventDispatcher {

    private var loaded:Boolean;
    private var eventDispatcher:EventDispatcher;
    private var data:Vector.<IClassConfiguration>;

    /**
     * Class constructor
     */
    public function Configuration() {
        this.loaded = false;
        this.eventDispatcher = new EventDispatcher();
        this.data = new Vector.<IClassConfiguration>;
    }

    /**
     * Sets the configuration loaded
     * @param loaded
     */
    public function setLoaded(loaded:Boolean):void {
        loaded = loaded;
    }

    /**
     * Checks if the configuration was loaded
     * @return
     */
    public function getLoaded():Boolean {
        return loaded;
    }

    /**
     * Returns only path to class
     * @param className
     * @return
     */
    public function getPathByClassName(className:String):String {
        for (var index:Number = 0; index < data.length; index++) {
            if (data[index].getClassName() == className) {
                return data[index].getClassPath();
            }
        }
        return null;
    }

    /**
     * Gets configuration by its name
     * @param name
     * @return
     */
    public function getConfigurationByName(name:String):IClassConfiguration {
        if (!this.getLoaded()) {
            return null;
        }
        var ret:IClassConfiguration;

        if (name.lastIndexOf(".") != -1) {
            //looks for configuration in class hierarchy
            for (; name.lastIndexOf(".") != -1; name = name.substring(0, name.lastIndexOf("."))) {
                ret = getConfigurationByKey(name);
                if (ret != null) break;
            }
        } else {
            return getConfigurationByKey(name);
        }


        return ret;
    }

    private function getConfigurationByKey(className:String):IClassConfiguration {
        for (var index:Number = 0; index < data.length; index++) {
            if (data[index].getClassName() == className) {
                return data[index];
            }
        }
        return null;
    }

    public function getXMLHandler():Function {
        return processXML;
    }

    private function processXML(xml:XML):void {
        for (var index:Number = 0; index < xml.children().length(); index++) {
            if (xml.children()[index].property[0] == null) {       //configuration file doesn't contain any additional properties
                this.data.push(new ClassConfiguration(xml.children()[index]));
            } else {
                this.data.push(new ExtendedClassConfiguration(xml.children()[index]));
            }
        }
        this.loaded = true;
        eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
    }

    public function hasEventListener(type:String):Boolean
    {
        return eventDispatcher.hasEventListener(type);
    }

    public function willTrigger(type:String):Boolean
    {
        return eventDispatcher.willTrigger(type);
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false):void
    {
        eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
    {
        eventDispatcher.removeEventListener(type, listener, useCapture);
    }

    public function dispatchEvent(event:Event):Boolean
    {
        return eventDispatcher.dispatchEvent(event);
    }

    public function toString():String {
        var ret:String = "";
        for (var index:Number = 0; index < data.length; index++) {
            ret = ret + data[index].getClassName() + "," + data[index].getClassPath() + "\n";
        }
        return ret;
    }
}
}