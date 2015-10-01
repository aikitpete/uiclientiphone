/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import uiclient.*;

import configurationreader.*;

import flash.events.*;

import mx.containers.Canvas;
import mx.controls.*;

import utils.*;

public class UIClient extends Canvas {

    private static const screenWidth:Number = 320;
    private static const screenHeight:Number = 480;

    public static var textArea:TextArea;
    public static var display:UIComponentsContainer;
    private static var imageLoader:Image;
    private static var currentDate:Date;


    private static var status:String;

    private static var instance:UIClient;

    public function UIClient() {
        super();
        init();
    }

    public static function getInstance():UIClient {
        if (instance == null) {
            instance = new UIClient();
        }
        return instance;
    }

    private function init():void {
        setStatus(ClientStatus.INITIALIZING);
        setStatus(ClientStatus.LOADING_CONFIGURATION);
        ConfigurationReader.reset();
        ConfigurationReader.addEventListener(Event.COMPLETE, configurationLoadedHandler);
        ConfigurationReader.init();
    }

    public function configurationLoadedHandler(e:Event):void {

        display = UIComponentsContainer.getInstance();

        if (ConfigurationReader.iPhoneMode == "false") {
            loadImage();
            loadText();
        }

        loadDisplay();

        UIDocument.init();
        UIProtocolToActionScript.init();
        UIProtocolValidator.init();
        UIProtocolPropertyResolver.init();
        UIComponentsContainer.init();
        UIClientConnection.init();
    }

    private function loadImage():void {
        imageLoader = new Image();
        imageLoader.x = 0;
        imageLoader.y = 0;
        imageLoader.load("resources/iPhone-mini copy cut.png");
        addChild(imageLoader);

    }

    private function loadText():void {
        textArea = new TextArea();
        textArea.height = 650;
        textArea.width = 500;
        textArea.x = 395;
        textArea.y = 0;
        textArea.setStyle("fontSize", "8");
        textArea.setStyle("fontFamily", "Lucida Console");
        textArea.setStyle("color", "green");
        addChild(textArea);
    }

    private function loadDisplay():UIComponentsContainer {
        if (ConfigurationReader.iPhoneMode == "false") {
            display.x = 35;
            display.y = 120;
        }
        display.width = screenWidth;
        display.height = screenHeight;
        display.setStyle("backgroundColor", 0xC5CCD3);
        addChild(display);
        return display;

    }

    public static function setStatus(value:String):void {
        status = value;
        if (textArea != null) debug(value.toUpperCase());
    }

    public static function getStatus():String {
        return status;
    }

    public static function debug(message:String):void {
        currentDate = new Date();
        if (ConfigurationReader.iPhoneMode == "false") {
            textArea.text = textArea.text + "[" + currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds() + "] " + message + "\n";
        }
        trace("[" + currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds() + "] " + message + "\n");
    }

}
}