/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uidocument.document {
/**
 * Specifies how to update the model. Complete update discards all data in current model and partial udpate
 * onvly overwrites properties that are contained in the update.
 */
public final class UpdateType {

    public static const COMPLETE:String = "complete";

    public static const PARTIAL:String = "partial";

    public static const INVALIDATE:String = "invalidate";

    public static const UNAVAILABLE:String = "unavailable";

    public static const COMPONENT:String = "component";

    public static const RECOVERY:String = "recovery";

    public static const PERSISTENT:String = "persistent";

}
}
