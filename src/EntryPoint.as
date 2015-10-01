/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import mx.core.*;
import UIClient;
/**
 * Class, which serves as an entry point to the UIProtocol Client for Apple iPhone
 */
public class EntryPoint {
    public static function main():void {
        trace("application started");
        var client:UIClient = UIClient.getInstance();
        var mxmlApp:Application = Application(Application.application);
        mxmlApp.addChild(client);
    }
}
}