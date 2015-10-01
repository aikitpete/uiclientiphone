/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.binding {

/**
 * Common interface for properties
 */
public interface IProperty {

    function getName():String;

    function setName(name:String):void;

    function getValue():String;

    function setValue(value:String):void;

    function getType():String;

    function setType(value:String):void;

    function getKey():String;

    function setKey(value:String):void;

    function getModifiers():String;

    function setModifiers(modifiers:String):void;

    function addListener(type:String, component:IUpdatable, property:IProperty = null):void;

    function stopBinding():void;

    function toString():String;
}
}