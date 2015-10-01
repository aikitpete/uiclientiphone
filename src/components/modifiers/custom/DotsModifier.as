/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.modifiers.custom{
import components.binding.IUpdatable;
import components.binding.events.BindingUpdateEvent;
import components.modifiers.*;

public class DotsModifier extends Modifier {

    public function DotsModifier(successor:IUpdatable) {
        super(successor);
    }

    override public function update(event:BindingUpdateEvent):void {
        event.setValue(event.getValue() + "...");
        successor.update(event);
    }
}
}