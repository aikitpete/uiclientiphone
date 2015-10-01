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

public class CapitalModifier extends Modifier {

    public function CapitalModifier(suc:IUpdatable) {
        super(suc);
    }

    override public function update(event:BindingUpdateEvent):void {
        event.setValue(normalizeTitle(event.getValue()));
        successor.update(event);
    }

    private function normalizeTitle(title:String):String
    {
        var words:Array = title.split(" ");
        var len:uint = words.length;
        for (var i:uint; i < len; i++)
        {
            words[i] = capitalizeFirstLetter(words[i]);
        }

        return words.join(" ");
    }

    /**
     * Capitalizes the first letter of a single word, unless it's one of
     * a set of words that are normally not capitalized in English.
     */
    private function capitalizeFirstLetter(word:String):String
    {
        switch (word)
        {
            case "and":
            case "the":
            case "in":
            case "an":
            case "or":
            case "at":
            case "of":
            case "a":
                // Don't do anything to these words.
                break;
            default:
                // For any other word, capitalize the first character.
                var firstLetter:String = word.substr(0, 1);
                firstLetter = firstLetter.toUpperCase();
                var otherLetters:String = word.substring(1);
                word = firstLetter + otherLetters;
        }
        return word;
    }
}
}