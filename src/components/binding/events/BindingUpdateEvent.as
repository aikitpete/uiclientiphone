/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.binding.events {

import components.binding.IProperty;
import components.binding.IUpdatable;
import components.binding.PropertyObject;

import flash.events.Event;

/**
 * The event sent when bound property is updated
 */
public class BindingUpdateEvent extends Event implements IProperty {

    public static const UPDATE:String = "update";

    private var property:IProperty;

    public function BindingUpdateEvent(type:String, property:IProperty) {
        super(type, false);
        this.property = new PropertyObject(property.getType(), property.getName(), property.getValue(), property.getKey(), "");
    }


    public function getName():String {
        return property.getName();
    }

    public function setName(name:String):void {
        property.setName(name);
    }

    public function getValue():String {
        return property.getValue();
    }

    public function setValue(value:String):void {
        property.setValue(value);
    }

    public function getType():String {
        return property.getType();
    }

    public function setType(value:String):void {
        property.setType(value);
    }

    public function getKey():String {
        return property.getKey();
    }

    public function setKey(value:String):void {
        property.setKey(value);
    }

    public function getModifiers():String {
        return property.getModifiers();
    }

    public function setModifiers(modifiers:String):void {
        property.setModifiers(modifiers);
    }

    public function addListener(type:String, component:IUpdatable, property:IProperty = null):void {
        property.addListener(type, component, property);
    }

    public function stopBinding():void {
        property.stopBinding();
    }

    public override function toString():String {
        return super.type + " " + property.toString();
    }
}
}