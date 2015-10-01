/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

import components.binding.*;

import utils.UIProtocolPropertyResolver;

/**
 * Class describing single model variant that is used in the interface.
 */
public class Variant extends Property {


    private var language:String;

    /**
     * Class constructor
     */
    public function Variant():void {
        super();
        language = null;
    }

    /**
     * Sets binding to a property or property container
     * @param modelwide specifies if the binding is model wide
     * @param component component on which the referencing property resides
     * @param properties that are going to be bound
     */
    public function setBinding(modelwide:Boolean, type:String, component:IUpdatable, properties:Vector.<IProperty>):void {
        if (!modelwide) {

            for (var i:Number = 0; i < properties.length; i++) {

                //retrieves lib.binding name from its key attribute
                var propertyName:String = properties[i].getKey().split(":")[1];

                //adds listener to the referenced lib.binding
                getPropertyByName(propertyName).addListener(type, component, properties[i]);

            }
        } else {

            //model wide binding
            var property:IProperty;
            for (var j:Number = 0; j < getLength(); j++) {

                property = getProperty(j);
                if (UIProtocolPropertyResolver.resolve(type, property)) {     //checks if property is valid for the type
                    if (!isOverriden(properties, property)) {
                        getProperty(j).addListener(type, component);
                    }
                }

            }
        }
    }

    /**
     * Checks if the property is not bound to other model
     * @param properties
     * @param property
     * @return
     */
    public function isOverriden(properties:Vector.<IProperty>, property:IProperty):Boolean {
        for (var i:Number = 0; i < properties.length; i++) {
            if (properties[i].getName() == property.getName()) {
                return true;
            }
        }
        return false;
    }

    /**
     * Discards all binding data stored in container and stops binding
     */
    public override function discardData():void {
        if (data != null) {
            var property:IProperty;
            for (var i:Number = 0; i < getLength(); i++) {
                property = getProperty(i);
                property.stopBinding();
            }
        }
        super.discardData();
    }


    /**
     * Tells whether the suplied variant is compatible with the specified one.
     *
     * @param variant that should be compared with this variant
     * @return true if the variant is compatible with the provided Variant, otherwise false
     */
    public function isCompatible(variant:Variant):Boolean {
        return false;
    }

}
}