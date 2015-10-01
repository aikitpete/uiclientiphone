/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package writer {

import components.binding.IProperty;
import components.uidocument.document.*;

/**
 * Class creating event XMLs
 */
public class PropertyWriter {

    /**
     * Creates an event XML, which contains an action
     * @param action
     * @param properties
     * @return
     */
    public static function processEvent(action:Action, properties:Vector.<IProperty>):XML {
        var xml:XML = new XML(<event/>);
        xml.@id = action.getId();
        if (properties != null) {
            for (var i:Number = 0; i < properties.length; i++) {
                xml.appendChild(<property/>);
                xml.property[i].@name = properties[i].getName();
                xml.property[i].@value = properties[i].getValue();
            }
        }
        return xml;
    }

    /**
     * Creates a request XML
     * @param type
     * @param classes
     * @return
     */
    public static function processRequest(type:String, classes:Array):XML {
        var xml:XML = new XML(<event/>);
        xml.@id = "public.request." + type;
        xml.appendChild(<property/>);
        type = "";
        for (var i:Number = 0; i < classes.length; i++) {
            type = type + classes[i];
            if (i == classes.length - 1) {
                break;
            }
            type = type + ",";
        }
        xml.property[0].@name = "class";
        xml.property[0].@value = type;
        return xml;
    }

}
}