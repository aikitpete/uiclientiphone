/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package components.modifiers {

import components.binding.IUpdatable;
import components.modifiers.custom.DotsModifier;

import configurationreader.ConfigurationReader;
import configurationreader.ObjectType;

import flash.utils.getDefinitionByName;

import UIClient;

public class ModifierFactory {

    public static function createModifier(modifierName:String, chainObject:IUpdatable):IUpdatable {

        var classPath:String = ConfigurationReader.getPathByClassName(modifierName, ObjectType.MODIFIER);

        if (classPath != null) {

            var ClassObj:Class = getDefinitionByName(ConfigurationReader.getPathByClassName(modifierName, ObjectType.MODIFIER)) as Class;
            var mod:Modifier = new ClassObj(chainObject);
            return mod;                                            //returns the created modifier

        } else {

            UIClient.debug("Unknown modifier: " + modifierName);
            return chainObject;                                    //returns the object received as parameter

        }

    }


    /**
     * Function containing calls to constructors, which is never used, but necessary for the program to run
     */
    public function unused():void {
        new LowercaseModifier(null);
        new UppercaseModifier(null);
        new CapitalModifier(null);
        new DotsModifier(null);
    }

}
}