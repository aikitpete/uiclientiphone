/**
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

import components.binding.IProperty;
import components.binding.IUpdatable;

/**
 * Model update is list of properties that should be updated in the specified model with additional
 * information regarding the update process.
 */
public class ModelUpdate {

    private var id:String;
    private var variants:Vector.<Variant>;
    private var type:String;
    private var interpolations:Array;
    private var duration:Number;
    private var event:String;

    /**
     * Class constructor
     * @param id of the model
     */
    public function ModelUpdate(id:String):void {
        this.id = id;
        this.variants = new Vector.<Variant>();
        this.type = null;
        this.interpolations = new Array();
        this.duration = 0;
        this.event = null;

    }

    /**
     * Sets binding to another property or container
     * @param modelwide specifies if the binding is modelwide
     * @param type of
     * @param component
     * @param properties
     */
    public function setBinding(modelwide:Boolean, type:String, component:IUpdatable, properties:Vector.<IProperty> = null):void {
        getVariant().setBinding(modelwide, type, component, properties);
    }

    /**
     * Updates the model properties with their new values specified in model update
     * @param newModel
     */
    public function update(newModel:ModelUpdate):void {

        //the model variant
        var newVariant:Property = newModel.getVariant();

        //type of update
        var updateType:String = newModel.getUpdateType();

        //discards old properties
        if (updateType == UpdateType.COMPLETE) {
            getVariant().discardData();
        }

        //updates every binding of the old model variant
        for (var i:Number = 0; i < newVariant.getLength(); i++) {

            var oldProperty:IProperty = getVariant().getPropertyByName(newVariant.getProperty(i).getName());
            var newProperty:IProperty = newVariant.getProperty(i);

            if (oldProperty != null) {
                oldProperty.setValue(newProperty.getValue());
            } else {
                getVariant().push(newProperty);
            }

        }
    }

    public function getId():String {
        return id;
    }

    public function addVariant(variant:Variant):void {
        this.variants.push(variant);
    }

    /**
     * Retrieves model variant used in the interface.
     *
     * @return variant of the model update
     */
    public function getVariant():Variant {
        return variants[0];
    }


    /**
     * Retrieves update type.
     *
     * @return update type
     */
    public function getUpdateType():String {
        return type;
    }

    /**
     * Retrieves update type.
     *
     * @return update type
     */
    public function setUpdateType(value:String):void {
        this.type = value;
    }

    public function toString():String {
        return id + "," + getVariant().toString();
    }

    public function getValueByName(str:String):IProperty {
        return variants[0].getPropertyByName(str);
    }

}
}
