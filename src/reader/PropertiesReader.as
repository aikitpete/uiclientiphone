/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package reader{

import components.binding.*;
import components.uidocument.DocumentObjectFactory;
import components.uidocument.document.*;

/**
 * Class for reading properties from UIProtocol document
 */
public class PropertiesReader {

    /**
     * Processes the uicomponents.binding container
     * @param xml the XML with the container data
     * @param isModel uicomponents.binding is part of UIProtocol model
     * @param type of the property
     * @return uicomponents.binding uicomponents.binding container
     */
    public static function processProperties(type:String, xml:XML = null, isModel:Boolean = false):Property {

        //creates an empty property container
        var property:Property = DocumentObjectFactory.createProperty();

        if (xml != null) {
            //sets the model for model wide uicomponents.binding
            property.setModel(xml.@model);

            if (xml.properties.length() >= 1) {
                for (var i:Number = 0; i < xml.properties.length(); i++) {
                    processValues(type, xml.properties[i], property, isModel);
                }
            }
            if (xml.property.length() >= 1) {
                for (var j:Number = 0; j < xml.property.length(); j++) {
                    if (xml.property[j].@value.length() != 0) {
                        property.push(processValue(type, xml.property[j].@name, xml.property[j].@value, xml.property[j].@key, isModel)); //adds property with value in its value tag
                    } else if (xml.property[j].length() != 0) {
                        property.push(processValue(type, xml.property[j].@name, xml.property[j], xml.property[j].@key, isModel));        //adds property with value in its body
                    }
                }
            }
        }
        return property;
    }

    /**
     * Processes multiple properties in single uicomponents.binding tag
     * @param xml the XML with the container data
     * @param property uicomponents.binding container
     * @param isModel uicomponents.binding is part of UIProtocol model
     */
    private static function processValues(type:String, xml:XML, property:Property, isModel:Boolean = false):void {

        if (xml.@names.length() > 0) {

            var names:Array = xml.@names.split(",");
            var values:Array;

            if (xml.@values.length() != 0) {

                //sets the value separator
                var separator:String = (xml.@separator.length() != 0) ? xml.@separator : ",";
                values = xml.@values.split(separator);

                //number of values must be same as number of names
                if (values.length != names.length) {
                    return;
                }

                //adds properties into container
                for (var i:Number = 0; i < names.length; i++) {
                    property.push(processValue(type, names[i], values[i], "", isModel));
                }
            }
            else if (xml.@keys.length() != 0) {

                values = xml.@keys.split(",");

                //number of values must be same as number of names
                if (values.length != names.length)
                    return;

                //adds the properties into container
                for (var j:Number = 0; j < names.length; j++) {
                    property.push(processValue(type, names[i], "", values[j], isModel));
                }
            }
        }
    }

    /**
     * Processes single property
     * @param name property name
     * @param value property value
     * @param isBindable property is part of a model
     * @return
     */
    private static function processValue(type:String, name:String, value:String, key:String, isModel:Boolean = false):IProperty {

        //returns null if property has no name
        if (name == "") {
            return null;
        }

        //processes uicomponents.modifiers
        var modifiers:String = "";
        if (key.indexOf("http://") != 0 && key.indexOf(":") != 0) {
            if (key.split(":", 3)[1]) {

                if (key.split(":", 3)[2]) {
                    modifiers = key.split(/[^:]*:[^:]*:/, 2)[1];
                }
                key = key.split(":", 2)[0] + ":" + key.split(":", 3)[1];
            }
        }

        //creates the property object
        if (!isModel) {
            return new PropertyObject(type, name, value, key, modifiers);
        } else {
            var bindableProperty:BindablePropertyObject = new BindablePropertyObject(type, name, value, key, "");
            return bindableProperty;
        }
    }

    public static function getPropertyFromAction(query:String):Property {
        /*var action:Action = dReader.findAction(query);
         if (action!=null)
         return action.getVariant();
         else*/
        return null;
    }

    public static function getPropertyFromEvent(query:String):Property {
        /*var event:Event = dReader.findEvent(query);
         if (event!=null)
         return event.getVariant();
         else*/
        return null;
    }

    public static function getPropertyFromInterface(query:String):Property {
        /*var iface:Interface = dReader.findInterface(query);
         //if (iface!=null)
         //    return iface.getVariant();
         else*/
        return null;
    }

    /**
     * Finds uicomponents.binding container of a model by its name
     * @param query name of the uicomponents.binding
     * @return
     */
    public static function getPropertyFromModel(query:String):Property {
        var model:ModelUpdate = UIDocumentReader.findModel(query);
        if (model != null) {
            return model.getVariant();
            //return new Property(model.getVariant(), false, model.getId());
        } else {
            return null;
        }
    }

}
}