/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument{
import components.uidocument.document.*;

/**
 * Class for creating UIProtocol document objects
 */
public class DocumentObjectFactory {

    /**
     * Creates an instance of model variant
     * @return
     */
    public static function createVariant():Variant {
        return new Variant();
    }

    /**
     * Creates an instance of position
     * @param xml
     * @param property
     * @return
     */
    public static function createPosition(xml:XML = null, property:Property = null):Position {
        return new Position((property == null) ? createProperty() : property);
    }

    /**
     * Creates an instance of behavior
     * @param xml
     * @param property
     * @return
     */
    public static function createBehavior(xml:XML = null, property:Property = null):Behavior {
        return new Behavior((xml == null) ? null : xml.@trigger, (xml == null) ? null : xml.@action, (property == null) ? createProperty() : property);
    }

    /**
     * Creates an instance of style
     * @param xml
     * @param property
     * @return
     */
    public static function createStyle(xml:XML = null, property:Property = null):Style {
        return new Style((property == null) ? createProperty() : property);
    }

    /**
     * Creates an instance of element
     * @param xml
     * @return
     */
    public static function createElement(xml:XML = null):Element {
        return new Element((xml == null) ? null : xml.attributes()[0]);
    }

    /**
     * Creates an istance of property container
     * @return
     */
    public static function createProperty():Property {
        return new Property();
    }

    /**
     * Creates an instance of model update
     * @param xml
     * @return
     */
    public static function createModelUpdate(xml:XML):ModelUpdate {
        return new ModelUpdate(xml.@id);
    }

    /**
     * Creates an instance of interface
     * @param xml
     * @return
     */
    public static function createInterface(xml:XML):Interface {
        return new Interface(xml.attributes()[0]);
    }

    /**
     * Creates an instance of container
     * @param xml
     * @return
     */
    public static function createContainer(xml:XML):Container {
        return new Container(xml.@id);
    }

    /**
     * Creates an instance of action
     * @param xml
     * @return
     */
    public static function createAction(xml:XML):Action {
        return new Action(xml.@id, xml.@execution);
    }

    /**
     * Creates an instance of UIDocument
     * @return
     */
    public static function createUIDocument():UIDocument {
        return new UIDocument();
    }
}
}