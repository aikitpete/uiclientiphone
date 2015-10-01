/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {

import flash.events.Event;
import flash.net.*;

/**
 * Class for loading XMLs
 */
public class XMLLoader {

    private var targetFunction:Function;

    public function XMLLoader(path:String, targetFunction:Function) {
        this.targetFunction = targetFunction;
        readXML(path);
    }

    private function readXML(path:String):void {
        var loader:URLLoader = new URLLoader();

        function eventHandler(e:Event):void {
            targetFunction(new XML(e.target.data));
        }

        loader.addEventListener(Event.COMPLETE, eventHandler);
        loader.load(new URLRequest(path));
    }

    public static function loadXML(path:String, handler:Function):void {
        new XMLLoader(path, handler);
    }
}
}