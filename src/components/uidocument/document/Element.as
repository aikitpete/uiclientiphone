/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

import components.binding.IProperty;

/**
 * Class representing element tag from UIProtocol document
 */
public class Element {

    private var id:String;
    private var style:Style;
    private var position:Position;
    private var behaviors:Vector.<Behavior>;
    private var property:Property;

    /**
     * Class constructor
     * @param id name of the element
     */
    public function Element(id:String):void {

        setId(id);
        this.behaviors = new Vector.<Behavior>();

    }

    /**
     * Retrieves element unique id. The id is unique in the scope of a single interface.
     *
     * @return unique id of the element in a interface
     */
    public function getId():String {
        return this.id;
    }

    /**
     * Sets id of the element.
     *
     * @param id of the element
     */
    public function setId(value:String):void {
        this.id = value;
    }

    /**
     * Gets the style of current element.
     *
     * @return style of the current element
     */
    public function getStyle():Style {
        return this.style;
    }

    /**
     * Sets style used by the component.
     *
     * @param style used by the component
     */
    public function setStyle(value:Style):void {
        this.style = value;
    }

    /**
     * Sets position of the element in parent container.
     *
     * @param position of the element in parent container
     */
    public function setPosition(value:Position):void {
        this.position = value;
    }

    /**
     * Retrieves position of the element.
     *
     * @return position of the element.
     */
    public function getPosition():Position {
        return this.position;
    }

    /**
     * Retrieves event triggers applied on the element.
     *
     * @return collection of event triggers applied on the element
     */
    public function getBehaviors():Vector.<Behavior> {
        return this.behaviors;
    }

    public function getBehaviorLength():Number {
        return this.behaviors.length;
    }

    public function getBehavior(index:Number):Behavior {
        return this.behaviors[index];
    }

    /**
     * Sets event for the element.
     *
     * @param behavior that should be added to the element
     */
    public function addBehavior(behavior:Behavior):void {
        if (behavior != null) this.behaviors.push(behavior);
    }

    /**
     * Retrieves the default property container of the element
     * @return property container
     */
    public function getProperties():Property {
        return property;
    }

    /**
     * Sets element properties
     * @param property container
     */
    public function setProperties(property:Property):void {
        this.property = property;
    }

    /**
     * Retrieves element property by its name
     * @param name
     * @return
     */
    public function getPropertyByName(name:String):IProperty {
        return this.property.getPropertyByName(name);
    }

    public function toString():String {
        var ret:String = "";
        ret = "class:" + id + "\nstyle:";
        if (style != null) ret = ret + style.toString();
        ret = ret + "\nposition:";
        if (position != null) ret = ret + position.toString();
        ret = ret + "\nproperties:"
        if (property != null) ret = ret + property.toString();
        return ret;
    }

}
}
