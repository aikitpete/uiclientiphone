/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.handlers.handlers {

import components.binding.*;
import components.uicomponents.DisplayObjectWrapper;
import components.uidocument.document.Property;

import flash.events.Event;

import writer.UIDocumentWriter;

public class EventHandler extends Handler {

    private var uiComponent:DisplayObjectWrapper;

    public function EventHandler(trigger:String, action:String, properties:Property, asClass:String, asType:String, uiComponent:DisplayObjectWrapper, implicit:Boolean = true) {
        super(trigger, action, properties, asClass, asType, implicit);
        this.uiComponent = uiComponent;
    }

    /**
     * Handles the event specified in UIDocument behavior tag
     * @param event event
     */
    public function eventHandler(event:Event):void {
        if (isImplicit()) {
            UIClient.debug("Event data: " + uiComponent.getDisplayObject()["text"]);
            var eventProperties:Vector.<IProperty> = Vector.<IProperty>([
                createImplicitProperty("text", uiComponent.getDisplayObject()["text"]),
            ]);

            mergeProperties(super.getProperties(), eventProperties);
            UIDocumentWriter.executeAction(super.getAction(), eventProperties);
        } else {
            UIClient.debug("Event");
            UIDocumentWriter.executeAction(super.getAction(), super.getProperties());
        }


    }

    public override function getHandlerFunction():Function {
        return eventHandler;
    }

}
}