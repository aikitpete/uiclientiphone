/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.setters {
import components.handlers.HandlerFactory;
import components.handlers.handlers.*;
import components.uicomponents.*;
import components.uidocument.document.*;

import flash.utils.getDefinitionByName;

/**
 * Class for setting behaviors of UI uicomponents
 */
public class BehaviorSetter extends Setter {


    public static function setBehaviorProperties(component:DisplayObjectWrapper, element:Element, parent:Property = null):void {

        var behavior:Behavior;
        var handler:Handler;
        var ClassObj:Class;

        for (var i:Number = 0; i < element.getBehaviorLength(); i++) {

            behavior = element.getBehavior(i);
            handler = HandlerFactory.createHandler(behavior.getTrigger(), behavior.getAction(), behavior.getProperties(), component);

            ClassObj = getDefinitionByName(handler.getAsClass()) as Class;
            component.addEventListener(ClassObj[handler.getAsType()], handler.getHandlerFunction());

        }
    }
}
}