package hxPaint;

import wanda.element.Element.*;
import wanda.virtual.VElement;
import cosmo.style.Style;

class PaintView
{
    public static function view(model :PaintModel) : VElement
    {
        var containerStyle1 = new Style();
        containerStyle1.direction = HORIZONTAL;
        containerStyle1.color = 0xffff0000;
        containerStyle1.width = PX(400);
        containerStyle1.height = PX(400);

        var buttonStyle1 = new Style();
        buttonStyle1.color = 0xffff00ff;
        buttonStyle1.width = PX(100);
        buttonStyle1.height = PX(100);

        var buttonStyle2 = new Style();
        buttonStyle2.color = 0xff00000f;
        buttonStyle2.width = PX(100);
        buttonStyle2.height = PX(100);

        var buttonStyle3 = new Style();
        buttonStyle3.color = 0xfffff0ff;
        buttonStyle3.width = PX(100);
        buttonStyle3.height = PX(100);

        var containerStyle2 = new Style();
        containerStyle2.direction = VERTICAL;
        containerStyle2.color = 0xff343ff0;
        containerStyle2.width = PX(200);
        containerStyle2.height = PX(500);

        return container(containerStyle1,
            [ button(buttonStyle1, [])
            , button(buttonStyle2, [])
            , button(buttonStyle3, [])
            , button(buttonStyle2, [])
            , button(buttonStyle1, [])
            , button(buttonStyle2, [])
            , container(containerStyle2, 
                [ button(buttonStyle1, [])
                , button(buttonStyle3, [])
                , button(buttonStyle1, [])
                ])
            ]);
    }

}