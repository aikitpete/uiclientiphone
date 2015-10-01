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

public class ElementSetter extends Setter {

    /**
     * Sets properties which belong to element tag
     * @param component ui component to set
     * @param element UIDocument element containing the properties
     * @param parent properties of parent interface
     */
    public static function setElementProperties(component:DisplayObjectWrapper, element:Element, parent:Property):void {
        setProperties(PropertyType.ELEMENT, component, element.getProperties(), element.getProperties().getModel(), parent);
    }
}
}