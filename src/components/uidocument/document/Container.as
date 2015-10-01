/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

/**
 * Element that can contain other elements and containers.
 */
public class Container extends Element {

    private var children:Array;

    public function Container(id:String):void {
        super(id);
        this.children = new Array();

    }

    /**
     * Retrieves list of children of the container.
     *
     * @return children of the container
     */
    public function getChildren():Array {
        return children;
    }


    /**
     * Adds new element into the container. This method also returns switcher that can be used to exchange the
     * element. If the exchange is not possible for any reason null is returned.
     *
     * @param element to be added to the container
     * @return switcher that can be used to exchange the inserted component
     */
    public function add(element:Element):void {
        children.push(element);
    }

}
}