package hxPaint;

import wanda.element.Element.*;
import wanda.virtual.VElement;
import cosmo.style.Style;

class PaintView
{
    public static function view(model :PaintModel) : VElement
    {
        var mainContainerStyle = new Style();
        mainContainerStyle.direction = HORIZONTAL;
        mainContainerStyle.width = PX(600);
        mainContainerStyle.height = PX(400);
        mainContainerStyle.color = 0xffaaaaaa;

        var leftColumn = new Style();
        leftColumn.x = PX(80);
        leftColumn.height = PX(100);
        leftColumn.width = PX(200);
        leftColumn.color = 0xff444444;

        var vDivider = new Style();
        vDivider.height = PX(400);
        vDivider.width = PX(20);
        vDivider.color = 0xffaaaaaa;

        var centerColumn = new Style();
        centerColumn.height = PX(100);
        centerColumn.width = PX(100);
        centerColumn.color = 0xff77ff77;

        var rightColumn = new Style();
        rightColumn.height = PX(100);
        rightColumn.width = PX(200);
        rightColumn.color = 0xff4444ff;

        return container(mainContainerStyle,
            [ container(leftColumn, 
                [
                ])
            , verticalDivider(vDivider)
            , container(centerColumn, 
                [
                ])
            // , verticalDivider(vDivider)
            , container(rightColumn, 
                [
                ])
            ]);
    }

}