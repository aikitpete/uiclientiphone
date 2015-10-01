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
 * Class writing XMLs containing informations about events that are sent to the server
 */
public class EventsWriter extends PropertyWriter {

    /**
     * Writes an XML with event end its properties
     * @param action which was triggered
     * @param properties vector with the event properties
     * @return xml with the event data
     */
    public static function writeEventXML(action:Action, properties:Vector.<IProperty>):XML {
        var xml:XML = new XML(<UIProtocol version="1.0"/>);
        xml.appendChild(<events/>);
        xml.events.appendChild(processEvent(action, properties));
        return xml;
    }

    /**
     * Writes and XML requesting missing classes
     * @param type of the class
     * @param classes of the classes
     * @return xml containing the request
     */
    public static function writeRequestXML(type:String, names:Array):XML {
        var xml:XML = new XML(<UIProtocol version="1.0"/>);
        xml.appendChild(<events/>);
        xml.events.appendChild(processRequest(type, names));
        return xml;
    }

}
}