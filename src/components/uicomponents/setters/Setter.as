/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.setters {
import components.binding.*;
import components.uicomponents.*;
import components.uidocument.document.*;

/**
 * Class for setting properties of UI uicomponents
 */
public class Setter {
    /**
     * Sets properties of a UI component
     * @param component ui component
     * @param properties properties container
     * @param parent properties of interface containing the parent container
     * @return ui component with properties set
     */
    public static function setProperties(type:String, component:DisplayObjectWrapper, properties:Property, model:String = "", parent:Property = null):void {

        if (model != "") {
            UIDocument.setBinding(true, type, component, properties.getData(), model);
        }

        for (var i:Number = 0; i < properties.getLength(); i++) {
            setProperty(type, component, properties.getProperty(i), parent);
        }

    }

    public static function setProperty(type:String, component:DisplayObjectWrapper, property:IProperty, parent:Property = null):void {


        if (property.getKey() == "") {         //binding is not referenced from a model

            component.setValue(property);

        } else if (property.getKey().indexOf(":") == 0) {

            if (parent != null) {

                //value referenced from parent interface
                var parentValue:String = parent.getValueByName(property.getKey().split(":")[1]);

                component.setValue(new PropertyObject(property.getType(), property.getName(), parentValue, "", "")); //sets value from external interface

            }

        } else {
            UIDocument.setBinding(false, type, component, Vector.<IProperty>([property]));     //bind to a model
        }
    }
}
}