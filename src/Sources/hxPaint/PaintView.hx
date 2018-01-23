package hxPaint;

import wanda.element.Element.*;
import wanda.virtual.VElement;
import cosmo.style.Style;

class PaintView
{
    public static function view(model :PaintModel) : VElement
    {
        var containerStyle = new Style();
        var buttonStyle = new Style();

        return container(containerStyle,
            [ button(buttonStyle, [])
            , button(buttonStyle, [])
            , button(buttonStyle, [])
            ]);
    }

}