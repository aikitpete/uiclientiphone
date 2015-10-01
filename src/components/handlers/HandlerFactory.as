/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.handlers {
import components.handlers.handlers.*;
import components.uicomponents.DisplayObjectWrapper;
import components.uidocument.document.Property;

import configurationreader.ConfigurationReader;
import configurationreader.ObjectType;

public class HandlerFactory {


    public static function createHandler(trigger:String, action:String, properties:Property, component:DisplayObjectWrapper):Handler {

        var flashTrigger:String = ConfigurationReader.getPathByClassName(trigger, ObjectType.TRIGGER);
        var handler:Handler;
        if (flashTrigger.indexOf("flash.events.Event.") == 0) {
            handler = new EventHandler(trigger, action, properties, flashTrigger.substring(0, flashTrigger.lastIndexOf(".")),
                    flashTrigger.substring(flashTrigger.lastIndexOf(".") + 1, flashTrigger.length), component);
        } else {
            handler = new MouseEventHandler(trigger, action, properties, flashTrigger.substring(0, flashTrigger.lastIndexOf(".")),
                    flashTrigger.substring(flashTrigger.lastIndexOf(".") + 1, flashTrigger.length));
        }

        return handler;

    }


}
}