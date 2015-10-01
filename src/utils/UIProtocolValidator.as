/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {

import components.uidocument.document.*;

import configurationreader.*;

/**
 * Class, which filters out restricted property types from property container
 */
public class UIProtocolValidator {

    //contains default values of position
    private static var positionProperties:Array;

    //contains default values of styles
    private static var styleProperties:Array;

    public static function init():void {
        styleProperties = ConfigurationReader.getDetailedConfigurationByClassName("styles", ObjectType.PROPERTY).getProperties();
        positionProperties = ConfigurationReader.getDetailedConfigurationByClassName("positions", ObjectType.PROPERTY).getProperties();
    }

    public static function validatePosition(position:Property):Boolean {

        for (var i:Number = 0; i < position.getLength(); i++) {

            for (var j:Number = 0; j <= positionProperties.length; j++) {

                //adds default value for property
                if (j == positionProperties.length) {

                    position.removeProperty(i);

                    break;
                }

                //property was found
                if (position.getProperty(i).getName() == positionProperties[j]["uiName"]) {

                    break;
                }

            }

        }
        return true;
    }

    public static function validateStyle(style:Property):Boolean {

        for (var k:Number = 0; k < style.getLength(); k++) {


            for (var l:Number = 0; l <= styleProperties.length; l++) {

                //property is invalid
                if (l == styleProperties.length) {

                    style.removeProperty(k);
                    k--;
                    break;

                }

                //property was found
                if (styleProperties[l]["uiName"] == style.getProperty(k).getName()) {

                    break;

                }

            }


        }

        for (var i:Number = 0; i < styleProperties.length; i++) {

            for (var j:Number = 0; j <= style.getLength(); j++) {

                //adds default value for property
                if (j == style.getLength()) {

                    //style.push(new PropertyObject(PropertyType.STYLE, styleProperties[i]["uiName"], styleProperties[i]["defaultValue"], "", ""));

                    break;

                }

                //property was found
                if (styleProperties[i]["uiName"] == style.getProperty(j).getName()) {

                    break;

                }
            }

        }
        return true;
    }

    public static function validateProperty(property:Property):Boolean {

        removeRestrictedProperties(property, positionProperties);
        removeRestrictedProperties(property, styleProperties);

        return true;
    }

    private static function removeRestrictedProperties(property:Property, restricted:Array):void {

        for (var i:Number = 0; i < property.getLength(); i++) {

            for (var j:Number = 0; j < restricted.length; j++) {

                //restricted property was found
                if (restricted[j]["uiName"] == property.getProperty(i).getName()) {

                    property.removeProperty(i);
                    i--;
                    break;

                }

            }

        }
    }

}
}
