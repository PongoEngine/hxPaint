package hxPaint;

import wanda.element.Element.*;
import wanda.virtual.VElement;

class PaintView
{
    public static function view(model :PaintModel) : VElement
    {
        return container(
            [ button([])
            , button([])
            , button([])
            ]);
    }
}