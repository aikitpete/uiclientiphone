/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.handlers.handlers {

import components.binding.IProperty;
import components.binding.PropertyObject;
import components.uidocument.document.Property;

/**
 * Abstract class
 */
public class Handler {

    private var trigger:String;
    private var asClass:String;
    private var asType:String;

    private var implicit:Boolean;

    private var action:String;
    private var properties:Vector.<IProperty>;

    public function Handler(trigger:String, action:String, property:Property, asClass:String, asType:String, implicit:Boolean = true) {
        this.trigger = trigger;
        this.asClass = asClass;
        this.asType = asType;
        this.action = action;
        this.properties = property.getData();
        this.implicit = implicit;
    }

    public function mergeProperties(event:Vector.<IProperty>, implicit:Vector.<IProperty>):void {
        for (var i:Number = 0; i < event.length; i++) {
            implicit.push(event[i]);
        }
    }

    public function createImplicitProperty(name:String, value:String):PropertyObject {
        return new PropertyObject(null, name, value, null, null);
    }

    public function getHandlerFunction():Function {
        return null
    }

    public function getAsClass():String {
        return asClass;
    }

    public function getAsType():String {
        return asType;
    }

    public function getAction():String {
        return action;
    }

    public function isImplicit():Boolean {
        return implicit;
    }

    public function getProperties():Vector.<IProperty> {
        return properties;
    }

}
}