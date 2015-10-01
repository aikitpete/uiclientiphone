/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents {

import components.binding.IProperty;
import components.binding.IUpdatable;
import components.binding.PropertyType;
import components.binding.events.BindingUpdateEvent;
import components.uicomponents.customcomponents.ExtendedVideoDisplay;
import components.uidocument.document.*;

import configurationreader.ConfigurationReader;
import configurationreader.IClassConfiguration;
import configurationreader.ObjectType;

import flash.display.*;
import flash.events.MouseEvent;
import flash.utils.getDefinitionByName;

import mx.controls.*;

import utils.UIProtocolToActionScript;

/**
 * Class which is used as a wrapper for every DisplayObject
 */
public class DisplayObjectWrapper implements IUpdatable {

    private var displayObject:DisplayObject;
    private var classConfiguration:IClassConfiguration;
    private var uiComponentClass:String;

    /**
     * Class constructor
     * @param element representing the component
     */
    public function DisplayObjectWrapper(element:Element) {

        this.uiComponentClass = element.getId();

        if (this.uiComponentClass.substr(0, 7) == "public.") {

            this.classConfiguration = ConfigurationReader.getDetailedConfigurationByClassName(this.uiComponentClass, ObjectType.COMPONENT);

            if (this.classConfiguration != null) {

                this.displayObject = createDisplayObject();
                setDefaultStyle();

            }

        } else {

            var iFace:Interface = UIDocument.findInterface(this.uiComponentClass);

            if (iFace != null) {

                this.displayObject = new UIComponentsContainer();
                setDefaultStyle();
                this.displayObject["displayInterface"](iFace, element.getProperties());

            }
        }
    }

    /**
     * Sets value which is part of element tag
     * @param uiProtocolName name in UIProtocol
     * @param value of the property
     */
    public function setElementValue(uiProtocolName:String, value:String):void {

        //interfaces do not have configuration
        if (classConfiguration == null) {
            return;
        }

        var actionScriptName:String = classConfiguration.uiProtocolToActionScript(uiProtocolName);

        if (actionScriptName.length > 3 && actionScriptName.lastIndexOf("()") == actionScriptName.length - 2) { //binding is set by function in AS

            if (value != "empty") {                                                                          //1 parameter

                displayObject[actionScriptName.substring(0, actionScriptName.length - 2)](value);

            } else {                                                                                        //no parameter

                displayObject[actionScriptName.substring(0, actionScriptName.length - 2)]();

            }

        } else {                                                                                       //sets the property using its ActionScript name

            displayObject[actionScriptName] = value;

        }
    }

    /**
     * Sets value of property which is defined as style
     * @param uiProtocolStyleName
     * @param value
     */
    public function setStyleValue(uiProtocolStyleName:String, value:*):void {

        var actionScriptStyleName:String = UIProtocolToActionScript.uiProtocolStyleToActionScriptStyle(uiProtocolStyleName);
        displayObject["setStyle"](actionScriptStyleName, value);

    }

    public function update(event:BindingUpdateEvent):void {
        setValue(event);
    }

    public function setValue(property:IProperty):void {

        //UIClient.debug("Property updated: "property.toString());

        switch (property.getType()) {
            case (PropertyType.ELEMENT):
                setElementValue(property.getName(), property.getValue());
                break;

            case (PropertyType.POSITION):
                displayObject[property.getName()] = property.getValue();
                break;

            case (PropertyType.STYLE):
                setStyleValue(property.getName(), property.getValue());
                break;

            default:
                UIClient.debug("Unsupported update type: " + property.getType());

        }


    }

    public function addEventListener(event:String, handler:Function):void {

        getDisplayObject().addEventListener(event, handler);

    }

    /**
     * Creates a displayobject from its class name
     * @return displayObjectClass class of the DisplayObject
     */
    private function createDisplayObject():DisplayObject {

        var DisplayObjectClass:Class = getDefinitionByName(classConfiguration.getClassPath()) as Class;
        return new DisplayObjectClass();

    }

    private function setDefaultStyle():void {
        var styleProperties:Array = ConfigurationReader.getDetailedConfigurationByClassName("styles", ObjectType.PROPERTY).getProperties();
        for (var i:Number = 0; i < styleProperties.length; i++) {
            displayObject["setStyle"](styleProperties[i]["asName"], styleProperties[i]["defaultValue"]);
        }
    }

    /**
     * Getter of the DisplayObject
     * @return instance of DisplayObject
     */
    public function getDisplayObject():DisplayObject {

        return displayObject;

    }

    public function getUIComponentClass():String {
        return this.uiComponentClass;
    }

    /**
     * Function containing calls to constructors, which is never used, but necessary for the program to run
     */
    public static function unused():void {

        new Image();
        new Button();
        new TextArea();
        new Label();
        new CheckBox();
        new VideoDisplay();
        new ExtendedVideoDisplay();
        new MouseEvent(null);

    }
}

}