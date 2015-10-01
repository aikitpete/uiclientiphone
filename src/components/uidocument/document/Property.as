/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

import components.binding.*;

/**
 * Represents property container
 */
public class Property {

    public var data:Vector.<IProperty>;

    //model
    private var model:String;

    /**
     * Class constructor
     * @param property from which the data should be set
     */
    public function Property(property:Property = null):void {
        this.model = "";
        if (property == null) {
            discardData();
        } else {
            this.model = property.getModel();
            this.data = property.getData();
        }
    }

    /**
     * Retrieves name of the model which the property is bound to
     * @return
     */
    public function getModel():String {
        return this.model;
    }

    /**
     * Sets name of the model which the property is bound to
     * @param value
     */
    public function setModel(value:String):void {
        this.model = value;
    }

    /**
     * Adds property into the container
     * @param property property which is being added
     */
    public function push(property:IProperty):void {
        this.data.push(property)
    }

    /**
     * Getter of the binding data
     * @return data binding data
     */
    public function getData():Vector.<IProperty> {
        return data;
    }

    /**
     * Discards all data stored in container
     */
    public function discardData():void {
        this.data = new Vector.<IProperty>();
    }

    /**
     * Sets data in property container
     * @param data
     */
    public function setData(data:Vector.<IProperty>):void {
        this.data = data;
    }

    /**
     * Finds property using its index
     * @param index
     * @return
     */
    public function getProperty(index:Number):IProperty {
        if (this.getLength() > index) return data[index];
        else return null;
    }

    /**
     * Retrieves value of property using its index
     * @param index
     * @return
     */
    public function getValue(index:Number):String {
        if (this.getLength() >= index) return data[index - 1].getValue();
        else return "";
    }

    /**
     * Retrieves Number value of property using its index
     * @param index
     * @return
     */
    public function getNumberValue(index:Number):Number {
        return int(getValue(index));
    }

    /**
     * Finds property by its name
     * @param name
     * @return
     */
    public function getPropertyByName(name:String):IProperty {
        for (var i:Number = 0; i < this.data.length; i++) {
            if (data[i].getName() == name) return data[i];
        }
        return null;
    }

    /**
     * Removes property from the container
     * @param index
     */
    public function removeProperty(index:Number):void {
        this.data.splice(index, 1);
    }

    /**
     * Finds property value by its name
     * @param str
     * @return
     */
    public function getValueByName(str:String):String {
        for (var i:Number = 0; i < this.data.length; i++)
            if (data[i].getName() == str) return data[i].getValue();
        return null;
    }

    /**
     * Gets property name on specified index
     * @param index
     * @return
     */
    public function getPropertyName(index:Number):String {
        return data[index].getName();
    }

    /**
     * Retrieves the number of properties stored in container
     * @return
     */
    public function getLength():Number {
        return data.length;
    }

    public function toString():String {
        var ret:String = "";
        for (var i:Number = 0; i < data.length; i++)
            ret = ret + data[i].toString();
        return ret;
    }

    public function compare(property:Property):Boolean {
        return false;
    }
}
}