/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package configurationreader {

/**
 * Class which holds class paths and detailed configuration of property mapping
 */
public class ExtendedClassConfiguration extends ClassConfiguration implements IClassConfiguration {

    private var classProperties:Array;

    /**
     * Translates UIProtocol name to ActionScript name
     * @param uiProtocol name
     * @return name in ActionScript
     */
    public override function uiProtocolToActionScript(uiProtocol:String):String {

        var property:Object = findProperty(uiProtocol);

        if (property != null) {

            return property.asName.toString();

        } else {

            return uiProtocol;

        }
    }

    public function ExtendedClassConfiguration(xmlData:XML) {
        super(xmlData);
        fillPropertiesContainer(xmlData);
    }

    private function fillPropertiesContainer(xmlData:XML):void {
        this.classProperties = new Array();
        for (var i:Number = 0; i < xmlData.children().length(); i++) {
            classProperties.push(createClassProperty(xmlData.children()[i]));
        }
    }

    private function createClassProperty(xmlData:XML):Object {
        var property:Object = new Object();
        for each(var attribute:XML in xmlData.attributes()) {
            property[attribute.name().toString()] = attribute.toString();
        }
        return property;
    }

    public override function findProperty(key:String):Object {
        for each(var property:Object in classProperties) {
            if (property.uiName == key) {
                return property;
            }
        }
        return null;
    }

    public override function getProperties():Array {
        return classProperties;
    }
}
}