/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package configurationreader {

/**
 * Class for storing class paths
 */
public class ClassConfiguration  implements IClassConfiguration {

    private var className:String;
    private var classPath:String;

    /**
     * Class constructor
     * @param xml containing the data
     */
    public function ClassConfiguration(xml:XML) {
        this.className = xml.@name;
        this.classPath = xml.@path;
    }

    public function getClassName():String {
        return className;
    }

    public function getClassPath():String {
        return classPath;
    }

    public function setClassName(className:String):void {
        this.className = className;
    }

    public function setClassPath(classPath:String):void {
        this.classPath = classPath;
    }

    public function findProperty(key:String):Object {
        return null;
    }

    public function uiProtocolToActionScript(uiProtocol:String):String {
        return uiProtocol;
    }

    public function getProperties():Array {
        return null;
    }
}
}