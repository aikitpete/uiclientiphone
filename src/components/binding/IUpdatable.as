/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.binding{

import components.binding.events.BindingUpdateEvent;

/**
 * Common interface for all objects, which can update their values
 */
public interface IUpdatable {

    function update(event:BindingUpdateEvent):void;

}
}