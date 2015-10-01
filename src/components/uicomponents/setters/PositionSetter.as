/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.setters {
import components.binding.PropertyType;
import components.uicomponents.*;
import components.uidocument.document.*;

/**
 * Class for setting position of UI uicomponents
 */
public class PositionSetter extends Setter {

    /**
     * Sets properties which belong to position tag
     * @param component ui component to set
     * @param position UIDocument posiiton containing the properties
     * @param parent properties of parent interface
     */
    public static function setPositionProperties(component:DisplayObjectWrapper, position:Position, parent:Property = null):void {
        setProperties(PropertyType.POSITION, component, position);
    }
}
}