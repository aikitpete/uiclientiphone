/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import components.binding.IProperty;
import components.binding.IUpdatable;
import components.uidocument.document.*;

import configurationreader.ObjectType;

import mx.collections.ArrayCollection;

import writer.UIDocumentWriter;

/**
 * The class used to store received interfaces and model updates
 */
public class UIDocument {

    private static var interfaces:Vector.<Interface>;
    private static var updates:Vector.<ModelUpdate>;
    private static var actions:Vector.<Action>;

    private static var requestedInterfaces:ArrayCollection;
    private static var requestedActions:ArrayCollection;

    public static function init():void {
        interfaces = new Vector.<Interface>;
        updates = new Vector.<ModelUpdate>;
        actions = new Vector.<Action>;
        requestedInterfaces = new ArrayCollection();
        requestedActions = new ArrayCollection();
    }

    public static function setBinding(isModelwide:Boolean, type:String, component:IUpdatable, properties:Vector.<IProperty>, model:String = null):void {
        var name:String;
        name = (model == null) ? properties[0].getKey().split(":")[0] : model;
        findModel(name).setBinding(isModelwide, type, component, properties);
    }

    public static function checkDisplayUpdate():void {

        checkRootChange();

    }

    /**
     * Checks if root has changed from displayed root
     */
    public static function checkRootChange():void {

        var root:String = getRootInterface();

        //if no interface is displayed
        if (root == null || root == "") {
            return;
        }

        //if root interface has changed
        if (UIComponentsContainer.getDisplayedRoot() != root) {
            UIComponentsContainer.updateDisplay(findInterface(root));
        }

    }

    /**
     * Gets current root interface
     * @return
     */
    public static function getRootInterface():String {
        var model:ModelUpdate = findModel("public.application");
        if (model == null) {
            return "";
        }
        var property:IProperty = model.getValueByName("about");
        if (property == null) {
            return "";
        }
        return property.getValue();
    }

    /**
     * Adds new interfaces into the lib.uidocument
     *
     * @param iface
     */
    public static function addInterface(iface:Interface):void {

        if (requestedInterfaces.contains(iface.getId())) {

            var displayedInterfaces:ArrayCollection = UIComponentsContainer.getDisplayedInterfaces();

            if (displayedInterfaces.contains(iface.getId)) {

                //reloads display with the missing interface
                requestedInterfaces.removeAll();
                interfaces.push(iface);
                UIComponentsContainer.updateDisplay(findInterface(getRootInterface()));
                return;

            } else {

                requestedInterfaces.removeItemAt(requestedInterfaces.getItemIndex(iface.getId()));

                interfaces.push(iface);

                //if the new interface is root calls display update
                var root:String = getRootInterface();
                if (root == iface.getId()) {
                    UIComponentsContainer.updateDisplay(findInterface(root));
                }
                return;

            }


        }
        interfaces.push(iface);
    }

    /**
     * Adds new model updates to the document.
     *
     * @param update
     */
    public static function addModelUpdate(update:ModelUpdate):void {

        //looks if the model is already present
        for (var i:Number = 0; i < updates.length; i++) {
            if (updates[i].getId() == update.getId()) {

                //executes model update
                updates[i].update(update);

                //checks if root has changed
                checkDisplayUpdate();

                return;
            }
        }

        //checks if root has changed
        checkDisplayUpdate();

        //adds new model
        updates.push(update);
    }

    /**
     * Adds new actions to the document.
     *
     * @param action
     */
    public static function addAction(action:Action):void {
        var id:String = action.getId();
        if (requestedActions.contains(id)) {
            requestedActions.removeItemAt(requestedActions.getItemIndex(id));
        }
        actions.push(action);
    }

    public static function findAction(action:String):Action {
        for (var i:Number = 0; i < actions.length; i++) {
            if (actions[i].getId() == action) {
                return actions[i];
            }
        }
        if (!requestedActions.contains(action)) {
            requestedActions.addItem(action);
            UIDocumentWriter.writeRequest(ObjectType.ACTION, new Array(action));
        }
        return null;
    }

    public static function findInterface(value:String):Interface {
        if (value != "") {
            for (var i:Number = 0; i < interfaces.length; i++) {
                if (interfaces[i].getId() == value) {

                    return interfaces[i];
                }
            }
            if (!requestedInterfaces.contains(value)) {

                requestedInterfaces.addItem(value);
                UIDocumentWriter.writeRequest(ObjectType.INTERFACE, new Array(value));

            }
        }

        return null;
    }

    /**
     * Finds model by its name
     * @param id of the model
     * @return
     */
    public static function findModel(id:String):ModelUpdate {
        for (var i:Number = 0; i < updates.length; i++) {
            if (updates[i].getId() == id)
                return updates[i];
        }
        return null;
    }

    /**
     * Retrieves stored interfaces.
     *
     * @return interfaces stored interfaces
     */
    public static function getInterfaces():Vector.<Interface> {
        return interfaces;
    }

    /**
     * Retrieves stored models.
     *
     * @return updates stored models
     */
    public static function getModelUpdates():Vector.<ModelUpdate> {
        return updates;
    }

    /**
     * Retrieves actions contained in the document.
     *
     * @return actions stored actions
     */
    public static function getActions():Vector.<Action> {
        return actions;
    }

}
}
