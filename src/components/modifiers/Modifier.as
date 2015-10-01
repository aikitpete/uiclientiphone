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

//Abstract class

public class Modifier implements IUpdatable {

    protected var successor:IUpdatable;

    public function Modifier(suc:IUpdatable) {
        setSuccessor(suc);
    }

    public function setSuccessor(successor:IUpdatable):void {
        this.successor = successor;
    }

    public function update(event:BindingUpdateEvent):void {
        successor.update(event);
    }


}
}