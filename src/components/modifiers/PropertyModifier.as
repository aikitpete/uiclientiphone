/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.modifiers{

import components.binding.IProperty;
import components.binding.IUpdatable;
import components.binding.events.BindingUpdateEvent;

public class PropertyModifier extends Modifier {

    private var name:String;
    private var type:String;

    public function PropertyModifier(type:String, successor:IUpdatable, property:IProperty) {
        super(successor);
        if (property != null) {
            this.name = name;
        }
        this.type = type;
    }

    override public function update(event:BindingUpdateEvent):void {
        if (name != null) {
            event.setName(name);
        }
        event.setType(type);
        successor.update(event);
    }
}
}