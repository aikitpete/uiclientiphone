/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.modifiers{

import components.binding.IUpdatable;
import components.binding.events.BindingUpdateEvent;

public class UppercaseModifier extends Modifier {

    public function UppercaseModifier(suc:IUpdatable) {
        super(suc);
    }

    override public function update(event:BindingUpdateEvent):void {
        event.setValue(event.getValue().toLocaleUpperCase());
        successor.update(event);
    }
}
}