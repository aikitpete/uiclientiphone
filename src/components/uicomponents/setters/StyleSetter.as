/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.setters {
import components.binding.*;
import components.uicomponents.*;
import components.uidocument.document.*;

/**
 * Class for setting style of UI uicomponents
 */
public class StyleSetter extends Setter {

    /**
     * Sets properties which belong to style tag
     * @param component ui component to set
     * @param style UIDocument style containing the properties
     * @param parent properties of parent interface
     */
    public static function setStyleProperties(component:DisplayObjectWrapper, style:Style, parent:Property = null):void {
        setProperties(PropertyType.STYLE, component, style, style.getModel(), parent);
    }
}
}