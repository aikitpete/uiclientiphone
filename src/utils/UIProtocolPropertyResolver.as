/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {

import components.binding.IProperty;
import components.binding.PropertyType;

import configurationreader.ConfigurationReader;
import configurationreader.ObjectType;

/**
 * Class which checks if property is of specified type
 */
public class UIProtocolPropertyResolver {

    //contains default values of position
    private static var positionProperties:Array;

    //contains default values of styles
    private static var styleProperties:Array;

    public static function init():void {
        styleProperties = ConfigurationReader.getDetailedConfigurationByClassName("styles", ObjectType.PROPERTY).getProperties();
        positionProperties = ConfigurationReader.getDetailedConfigurationByClassName("positions", ObjectType.PROPERTY).getProperties();
    }

    public static function resolve(type:String, property:IProperty):Boolean {
        switch (type) {
            case PropertyType.ELEMENT:
                return resolveElementProperty(property);

            case PropertyType.STYLE:
                return resolveStyleProperty(property);

            case PropertyType.POSITION:
                return resolvePositionProperty(property);

            default:
                return false;
        }
    }

    public static function resolveElementProperty(property:IProperty):Boolean {
        if (resolveProperty(property, styleProperties) || resolveProperty(property, positionProperties)) {
            return false;
        }
        return true;
    }

    public static function resolveStyleProperty(property:IProperty):Boolean {
        return resolveProperty(property, styleProperties);
    }

    public static function resolvePositionProperty(property:IProperty):Boolean {
        return resolveProperty(property, positionProperties);
    }

    private static function resolveProperty(property:IProperty, properties:Array):Boolean {

        for (var i:Number = 0; i < properties.length; i++) {

            //property was found
            if (properties[i]["uiName"] == property.getName()) {
                return true;
            }

        }
        return false;
    }

}
}