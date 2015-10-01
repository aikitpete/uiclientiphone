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
 * Class for reading UIProtocol document actions
 */
public class ActionsReader extends PropertiesReader {

    public static function processAction(xml:XML):Action {
        var action:Action = DocumentObjectFactory.createAction(xml);
        return action;
    }

}
}