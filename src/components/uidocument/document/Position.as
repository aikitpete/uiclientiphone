/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {

/**
 * Class providing access to
 */
public class Position extends Property {

    public function Position(property:Property) {
        super(property);
    }

    /**
     * Retrieves X coordinate
     * @return
     */
    public function getX():Number {
        return getNumberValue(1);

    }

    /**
     * Retrieves Y coordinate
     * @return
     */
    public function getY():Number {
        return getNumberValue(2);

    }

    /**
     * Retrieves width
     * @return
     */
    public function getWidth():Number {
        return getNumberValue(3);

    }

    /**
     * Retrieves height
     * @return
     */
    public function getHeight():Number {
        return getNumberValue(4);

    }

    override public function toString():String {
        return "X:" + getX() + ",Y:" + getY() + ",Width:" + getWidth() + ",Height:" + getHeight();
    }

}
}
