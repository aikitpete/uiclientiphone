/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.handlers.handlers {

import components.binding.*;
import components.uidocument.document.Property;

import flash.events.MouseEvent;

import writer.UIDocumentWriter;

public class MouseEventHandler extends Handler {

    public function MouseEventHandler(trigger:String, action:String, properties:Property, asClass:String, asType:String, implicit:Boolean = true) {
        super(trigger, action, properties, asClass, asType, implicit);
    }

    /**
     * Handles the event specified in UIDocument behavior tag
     * @param mouseEvent event
     */
    public function eventHandler(mouseEvent:MouseEvent):void {

        if (isImplicit()) {
            UIClient.debug("MouseEvent data: " + mouseEvent.target.toString().substring(mouseEvent.target.toString().lastIndexOf(".") + 1) + "1");
            var eventProperties:Vector.<IProperty> = Vector.<IProperty>([
                createImplicitProperty("pointer.button", mouseEvent.target.toString().substring(mouseEvent.target.toString().lastIndexOf(".") + 1)),
                createImplicitProperty("pointer.count", "1")
            ]);
            mergeProperties(super.getProperties(), eventProperties);
            UIDocumentWriter.executeAction(super.getAction(), eventProperties);
        } else {
            UIClient.debug("MouseEvent");
            UIDocumentWriter.executeAction(super.getAction(), super.getProperties());
        }


    }


    public override function getHandlerFunction():Function {
        return eventHandler;
    }

}
}