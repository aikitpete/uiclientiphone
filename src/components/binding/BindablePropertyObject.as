/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.binding{

import components.binding.events.BindingUpdateEvent;
import components.modifiers.*;

import mx.events.PropertyChangeEvent;

/**
 * Property used in models, which can be bound to other property
 */
[Bindable]
public class BindablePropertyObject implements IUpdatable, IProperty {

    private var name:String;
    private var value:String;
    private var key:String;
    private var modifiers:String;
    private var listeners:Vector.<Vector.<Function>>;
    private var type:String;

    public function BindablePropertyObject(type:String, name:String = "", value:String = "", key:String = "", modifiers:String = "") {
        super();
        this.name = name;
        this.value = value;
        this.key = key;
        this.modifiers = modifiers;
        this.listeners = new Vector.<Vector.<Function>>;
        this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
        if (type != PropertyType.MODEL && type != PropertyType.BEHAVIOR) {
            this.type = PropertyType.UNKNOWN;
        } else {
            this.type = type;
        }
    }

    /**
     * Adds a listener to the property, which is listening for updates
     * @param property referencing property
     * @param setter ui component which owns the property
     */
    public function addListener(type:String, iUpdatable:IUpdatable, property:IProperty = null):void {

        //adjusts the property name and type for binding
        var currentSetter:IUpdatable = new PropertyModifier(type, iUpdatable, property);

        //if property is not model wide binded
        if (property != null) {

            //add modifiers
            if (property.getModifiers().length != 0) {
                var modifiers:Array = property.getModifiers().split(":");
                for (var i:Number = 0; i < modifiers.length; i++) {

                    currentSetter = ModifierFactory.createModifier(modifiers[i].toString(), currentSetter);

                }

            }
        }

        this.listeners.push(Vector.<Function>([iUpdatable.update, currentSetter.update]));
        currentSetter.update(new BindingUpdateEvent(BindingUpdateEvent.UPDATE, this));
    }

    public function propertyChangeHandler(event:PropertyChangeEvent):void {

        for (var i:Number = 0; i < listeners.length; i++) {
            listeners[i][1](new BindingUpdateEvent(BindingUpdateEvent.UPDATE, this));
        }

    }

    public function removeListener(listener:Function):void {
        for (var i:Number = 0; i < listeners.length; i++) {
            if (listeners[i][0] == listener) {

            }
        }
    }

    public function removeAllListeners():void {
        this.listeners = new Vector.<Vector.<Function>>;
    }

    public function update(event:BindingUpdateEvent):void {
        this.value = event.getValue();
    }

    public function getName():String {
        return this.name;
    }

    public function setName(name:String):void {
        this.name = name;
    }

    public function getValue():String {
        return this.value;
    }

    public function setValue(value:String):void {
        this.value = value;
        this.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
    }

    public function getKey():String {
        return this.key;
    }

    public function setKey(value:String):void {
        this.key = key;
    }

    public function getModifiers():String {
        return this.modifiers;
    }

    public function setModifiers(modifiers:String):void {
        this.modifiers = modifiers;
    }

    public function toString():String {
        return "Type:" + this.getType() + "Name:" + this.getName + ",Value:" + this.getValue() + "Key:" + this.getKey() + ",Modifiers:" + this.getModifiers();
    }

    public function stopBinding():void {

    }

    public function getType():String {
        return this.type;
    }

    public function setType(value:String):void {
    }
}
}