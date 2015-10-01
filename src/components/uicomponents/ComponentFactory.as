/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents{

import components.uicomponents.setters.*;
import components.uidocument.document.*;

/**
 * Class for creating instances of UI uicomponents
 */
public class ComponentFactory {

    public static function createUIComponent(element:Element, parent:Property):DisplayObjectWrapper {

        var uiComponent:DisplayObjectWrapper = new DisplayObjectWrapper(element);
        if (uiComponent.getDisplayObject() != null) {
            ComponentSetter.setComponent(uiComponent, element, parent);
        }
        return uiComponent;

    }

}
}