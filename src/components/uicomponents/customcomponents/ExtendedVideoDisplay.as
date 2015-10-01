/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.uicomponents.customcomponents {

import flash.display.DisplayObjectContainer;

import mx.controls.VideoDisplay;

/**
 * UI component for playing videos
 */
public class ExtendedVideoDisplay extends VideoDisplay {
    public function ExtendedVideoDisplay() {
        super();
    }

    public override function parentChanged(p:DisplayObjectContainer):void
    {
        if (this.playing) {
            super.stop();
        }
        super.close();
        super.parentChanged(p);
    }
}
}