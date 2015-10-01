/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {

import components.uicomponents.ComponentFactory;
import components.uicomponents.DisplayObjectWrapper;
import components.uidocument.document.*;

import flash.display.*;

import mx.collections.ArrayCollection;
import mx.containers.Canvas;

public class UIComponentsContainer extends Canvas {

    private static var instance:UIComponentsContainer;
    private static var displayedRoot:String = "";

    private static var displayedInterfaces:ArrayCollection;

    //multiple instances can be made, can be used in nested interfaces
    public function UIComponentsContainer() {
        super();
    }

    public static function getInstance():UIComponentsContainer {
        if (instance == null) {
            instance = new UIComponentsContainer();
        }
        return instance;
    }

    public static function init():void {
        displayedInterfaces = new ArrayCollection();
    }

    public static function updateDisplay(iface:Interface):void {
        if (iface != null) {

            //resets list displayed interfaces
            displayedInterfaces = new ArrayCollection();

            //removes all displayed UI uicomponents.uicomponents
            getInstance().removeAllChildren();

            displayedRoot = iface.getId();
            getInstance().displayInterface(iface);

        }

    }

    public function displayInterface(iface:Interface, properties:Property = null):void {

        //adds the interface into list of displayed interfaces
        displayedInterfaces.addItem(iface.getId());

        for each (var element:Element in iface.getRoot().getChildren()) {

            //UIClient.debug("Displaying\n"+element.toString()+"\n");

            displayUIComponent(ComponentFactory.createUIComponent(element, properties));

            //UIClient.debug("Element displayed\n");

        }
    }

    private function displayUIComponent(displayObjectWrapper:DisplayObjectWrapper):void {
        var displayObject:DisplayObject = displayObjectWrapper.getDisplayObject();

        if (displayObject != null) {

            addChild(displayObject);

        } else {

            UIClient.debug("Undefined element: " + displayObjectWrapper.getUIComponentClass());

        }
    }

    public static function getDisplayedRoot():String {
        return displayedRoot;
    }

    public static function getDisplayedInterfaces():ArrayCollection {
        return displayedInterfaces;
    }

    override public function toString():String {
        return "width:" + this.width + ",height" + this.height;
    }

}

}