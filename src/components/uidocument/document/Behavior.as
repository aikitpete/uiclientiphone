/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

/**
 * Class which represents behaviors from UIProtocol document
 */
public class Behavior extends Property {

    private var trigger:String;
    private var name:String;
    private var properties:Property;

    /**
     * Class constructor
     * @param trigger of the behavior
     * @param name of the action which is executed
     * @param properties of the behavior
     */
    function Behavior(trigger:String, name:String, properties:Property) {
        this.trigger = trigger;
        this.name = name;
        this.properties = properties;
    }

    /**
     * Specified in which circumstances the action is executed.
     *
     * @return trigger causing the action to execute
     */
    public function getTrigger():String {
        return this.trigger;
    }

    /**
     * Retrieves action that is executed after trigger is triggered.
     *
     * @return name of the action to be executed
     */
    public function getAction():String {
        return this.name;
    }

    /**
     * Retrieves properties of the behavior
     * @return properties inside the behavior tag
     */
    public function getProperties():Property {
        return this.properties;
    }


}
}
