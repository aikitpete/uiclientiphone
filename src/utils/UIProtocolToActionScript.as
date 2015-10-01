/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {
import configurationreader.*;

/**
 * Class responsible for translating property names from UIProtocol to ActionScript
 */
public class UIProtocolToActionScript {

    //contains default values of styles
    private static var styleProperties:Array;


    public static function init():void {
        styleProperties = ConfigurationReader.getDetailedConfigurationByClassName("styles", ObjectType.PROPERTY).getProperties();
        if (styleProperties == null) UIClient.debug("posnull");
    }

    /**
     * Translates UIProtocol style name to ActionScript style name
     * @param uiProtocolName name in UIProtocol
     * @return name in ActionScript
     */
    public static function uiProtocolStyleToActionScriptStyle(uiProtocol:String):String {

        for (var i:Number = 0; i < styleProperties.length; i++) {
            if (uiProtocol == styleProperties[i]["uiName"]) {
                return styleProperties[i]["asName"];
            }
        }

        return null;

    }
}
}