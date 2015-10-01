/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package reader{

import components.binding.*;
import components.uidocument.document.*;

/**
 * Class for loading data from received UIProtocol documents
 */
public class UIDocumentReader {

    private static var instance:UIDocumentReader;

    public function UIDocumentReader() {

    }

    public static function processDocument(xmlIn:XML):void {
        processMainContainer(xmlIn);
    }

    private static function processMainContainer(xmlIn:XML):void {
        readModels(xmlIn);
        readActions(xmlIn);
        readInterfaces(xmlIn);

    }

    public static function readModels(xmlIn:XML):void {
        if (xmlIn.models.length() != 0) {
            var mContainer:XML = xmlIn.models[0];
            for (var i:Number = 0; i < mContainer.children().length(); i++) {
                UIDocument.addModelUpdate(ModelsReader.processModel(PropertyType.MODEL, mContainer.children()[i]));
            }
            UIClient.debug("Models processed");
        }
    }

    public static function readInterfaces(xmlIn:XML):void {
        if (xmlIn.interfaces.length() != 0) {
            var iContainer:XML = xmlIn.interfaces[0];
            for (var j:Number = 0; j < iContainer.children().length(); j++) {
                UIDocument.addInterface(InterfacesReader.processInterface(iContainer.children()[j]));
            }
            UIClient.debug("Elements processed");
        }
    }

    public static function readActions(xmlIn:XML):void {
        if (xmlIn.actions.length() != 0) {
            var aContainer:XML = xmlIn.actions[0];
            for (var k:Number = 0; k < aContainer.children().length(); k++) {
                var action:Action = ActionsReader.processAction(aContainer.children()[k])
                for (var l:Number = 0; l < aContainer.children()[k].children().length(); l++) {
                    action.addModelUpdate(processModel(PropertyType.BEHAVIOR, aContainer.children()[k].children()[l]));
                }
                UIDocument.addAction(action);
            }
            UIClient.debug("Actions processed");
        }
    }

    public static function processModel(type:String, xml:XML):ModelUpdate {
        return ModelsReader.processModel(type, xml);
    }

    public static function findAction(action:String):Action {
        //UIClient.debug((UIDocument.getInstance().findAction(action)==null).toString());
        return UIDocument.findAction(action);
    }

    public static function findInterface(iface:String):Interface {
        return UIDocument.findInterface(iface);
    }

    public static function findModel(model:String):ModelUpdate {
        return UIDocument.findModel(model);
    }


}
}