/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.binding {

/**
 * Class, which represents a non-bindable property
 */
public class PropertyObject implements IProperty {

    public var name:String;
    public var value:String;
    public var key:String;
    public var modifiers:String;
    public var type:String;

    public function PropertyObject(type:String, name:String, value:String, key:String, modifiers:String) {
        this.name = name;
        this.value = value;
        this.key = key;
        this.modifiers = modifiers;
        this.type = type;
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
    }

    public function getModifiers():String {
        return this.modifiers;
    }

    public function setModifiers(modifiers:String):void {
        this.modifiers = modifiers;
    }

    public function toString():String {
        return "Type:" + this.getType() + "Name:" + this.getName() + ",Value:" + this.getValue() + "Key:" + this.getKey() + ",Modifiers:" + this.getModifiers();
    }

    public function addListener(type:String, component:IUpdatable, property:IProperty = null):void {
    }

    public function stopBinding():void {
    }

    public function getKey():String {
        return key;
    }

    public function setKey(value:String):void {
        this.key = value;
    }

    public function getType():String {
        return this.type;
    }

    public function setType(value:String):void {
        this.type = value;
    }
}
}