/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

/**
 * Interface describing what's happening on the client side when an event gets executed.
 */
public class Action {

    private var id:String;
    private var execution:String;
    private var access:String;
    private var updates:Vector.<ModelUpdate>;

    public function Action(id:String, execution:String):void {
        this.id = id;
        this.execution = execution;
        this.access = ActionAccess.USER;
        this.updates = new Vector.<ModelUpdate>;
    }

    /**
     * Retrieves type of access to the action. User action can be accessed directly by user, while system
     * actions can be executed only by client.
     *
     * @return access to the action
     */
    public function getAccess():String {
        return access;
    }

    /**
     * Retrieves id of the action
     *
     * @return id of the action
     */
    public function getId():String {
        return id;
    }

    /**
     * Retrieves execution type of the action
     *
     * @return execution type
     */
    public function getExecution():String {
        return execution;
    }

    /**
     * Retrieves list of model updates on the client side.
     *
     * @return model updates that should occur on client side, if supported
     */
    public function getModelUpdates():Vector.<ModelUpdate> {
        return updates;
    }

    /**
     * Adds a model update
     *
     * @param modelUpdate to be added
     */
    public function addModelUpdate(modelUpdate:ModelUpdate):void {
        updates.push(modelUpdate);
    }

    public function toString():String {
        return id;
    }

}
}
