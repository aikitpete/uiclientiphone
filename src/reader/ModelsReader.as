/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package reader{

import components.uidocument.DocumentObjectFactory;
import components.uidocument.document.*;

/**
 * Class for reading UIProtocol document models
 */
public class ModelsReader extends PropertiesReader {

    public static function processModel(type:String, xml:XML):ModelUpdate {
        var model:ModelUpdate = DocumentObjectFactory.createModelUpdate(xml);
        model.addVariant(processVariant(type, xml));
        if (xml.@update != null) {
            model.setUpdateType(xml.@update);
        } else {
            model.setUpdateType(UpdateType.PARTIAL);
        }
        return model;
    }

    private static function processVariant(type:String, xml:XML):Variant {
        var variant:Variant = DocumentObjectFactory.createVariant();
        variant.setData(processProperties(type, xml, true).getData());
        return variant;
    }

}
}