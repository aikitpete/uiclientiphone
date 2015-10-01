/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package reader{

import components.binding.PropertyType;
import components.uidocument.DocumentObjectFactory;
import components.uidocument.document.*;

import utils.UIProtocolValidator;

/**
 * Class for reading UIProtocol document interfaces
 */
public class InterfacesReader extends PropertiesReader {

    public static function processInterface(xml:XML):Interface {
        var iFace:Interface = DocumentObjectFactory.createInterface(xml);
        iFace.setRoot(processContainer(xml.children()[0]));
        return iFace;
    }

    private static function processContainer(xml:XML):Container {
        var container:Container = DocumentObjectFactory.createContainer(xml.children()[0]);
        setElement(xml, container);
        fillContainer(container, xml);
        return container;
    }

    private static function fillContainer(container:Container, xml:XML):void {
        for (var i:Number = 0; i < xml.children().length(); i++) {
            container.add(processElement(xml.children()[i]));
        }
    }

    private static function processElement(xml:XML):Element {
        var element:Element = DocumentObjectFactory.createElement(xml);
        setElement(xml, element);
        return element;
    }

    private static function setElement(xml:XML, element:Element):void {

        element.setPosition(processPosition(xml.position[0]));
        element.setStyle(processStyle(xml.style[0]));

        for (var index:Number = 0; index < xml.behavior.length(); index++) {
            element.addBehavior(processBehavior(xml.behavior[index]));
        }

        var property:Property;
        property = processProperties(PropertyType.ELEMENT, xml, false);
        UIProtocolValidator.validateProperty(property);
        element.setProperties(property);
    }

    private static function processPosition(xml:XML):Position {
        var position:Position;

        if (xml != "") {

            position = DocumentObjectFactory.createPosition(xml, processProperties(PropertyType.POSITION, xml, false));

        } else {

            position = DocumentObjectFactory.createPosition();

        }

        UIProtocolValidator.validatePosition(position);
        return position;
    }

    private static function processStyle(xml:XML):Style {
        var style:Style;

        if (xml != "") {

            style = DocumentObjectFactory.createStyle(xml, processProperties(PropertyType.STYLE, xml, false));

        } else {

            style = DocumentObjectFactory.createStyle();

        }

        UIProtocolValidator.validateStyle(style);
        return style;

    }

    private static function processBehavior(xml:XML):Behavior {
        if (xml.length() != 0) {
            var behavior:Behavior = DocumentObjectFactory.createBehavior(xml, processProperties(PropertyType.BEHAVIOR, xml, false));
            UIDocumentReader.findAction(behavior.getAction());       //checks if action is loaded
            return behavior;
        }
        else {
            return DocumentObjectFactory.createBehavior();
        }
    }

}
}