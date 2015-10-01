/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

/**
 * Complete interface of the specified class.
 */
public class Interface {

    private var root:Container;
    private var id:String;
    //private var children:Array;

    /**
     * Class constructor
     * @param id of the interface
     */
    public function Interface(id:String) {
        trace("Interface created");
        this.id = id;

    }

    /**
     * Retrieves root container of the interface.
     *
     * @return root container of the interface
     */
    public function getRoot():Container {
        return this.root;
    }

    /**
     * Sets root node of the interface.
     *
     * @param root of the interface
     */
    public function setRoot(root:Container):void {
        this.root = root;
    }

    /**
     * Adds the specified element into interface.
     *
     * @param element to be added into interface
     */
    public function addElement(element:Element):void {
        this.getRoot().add(element);
    }

    /**
     * Retrieves id of the element containing children.
     *
     * @return id of the element containing children
     */
    public function getChildrenContainer():String {
        return this.root.getId();
    }

    /**
     * Retrieves id of the interface
     * @return id of the interface
     */
    public function getId():String {
        return this.id;
    }

    /**
     * Sets id of the interface
     * @param id of the interface
     */
    public function setId(id:String):void {
        this.id = id;
    }

    public function toString():String {
        return this.id;
    }

}
}
