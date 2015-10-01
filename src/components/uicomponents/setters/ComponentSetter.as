/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.setters {
import components.uicomponents.*;
import components.uidocument.document.*;

/**
 * Class for setting properties of a UI component
 */
public class ComponentSetter {

    /**
     * Sets properties of a component
     * @param component to be set
     * @param element containing the properties
     * @param parent properties of interface containing the parent container
     */
    public static function setComponent(component:DisplayObjectWrapper, element:Element, parent:Property):void {

        ElementSetter.setElementProperties(component, element, parent);
        //UIClient.debug(element.getId()+" UI component properties set");

        PositionSetter.setPositionProperties(component, element.getPosition(), parent);
        //UIClient.debug(element.getId()+" UI component position set");

        StyleSetter.setStyleProperties(component, element.getStyle(), parent);
        //UIClient.debug(element.getId()+" UI component style set");

        BehaviorSetter.setBehaviorProperties(component, element, parent);
        //UIClient.debug(element.getId()+" UI component handlers set");

    }


}
}