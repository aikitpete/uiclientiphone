/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package writer{

import components.binding.IProperty;
import components.uidocument.document.*;

public class UIDocumentWriter {

    private static function findAction(action:String):Action {
        return UIDocument.findAction(action);
    }

    public static function writeRequest(type:String, classes:Array):void {
        sendMessage(EventsWriter.writeRequestXML(type, classes));
    }

    public static function executeAction(actionName:String, properties:Vector.<IProperty>):void {
        var action:Action = findAction(actionName);
        if (action != null) {

            //performs all model updates included in the action
            var updates:Vector.<ModelUpdate> = action.getModelUpdates();
            for (var i:Number = 0; i < updates.length; i++) {
                UIDocument.addModelUpdate(updates[i]);
            }

            if (action.getExecution() == ActionType.SERVER) {
                sendMessage(EventsWriter.writeEventXML(action, properties));
            }
        } else {
            UIClient.debug("Undefined action: " + actionName);
        }
    }

    private static function sendMessage(xml:XML):void {
        UIClientConnection.send(xml);
    }

}
}