/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package configurationreader {

/**
 * Interface shared by classes for storing configuration
 */
public interface IClassConfiguration {

    function uiProtocolToActionScript(uiProtocol:String):String;

    function getClassName():String;

    function getClassPath():String;

    function getProperties():Array;

    function setClassName(className:String):void;

    function setClassPath(classPath:String):void;

    function findProperty(key:String):Object;

}
}