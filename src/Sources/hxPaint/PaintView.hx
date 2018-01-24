package hxPaint;

import wanda.element.Element.*;
import wanda.virtual.VElement;
import cosmo.style.Style;
import jasper.Strength;

class PaintView
{
    public static function view(model :PaintModel) : VElement
    {
        var mainContainerStyle = new Style();
        mainContainerStyle.direction = VERTICAL;
        mainContainerStyle.width = PERCENT(1, Strength.MEDIUM);
        mainContainerStyle.color = 0xffaaaaaa;

        var toolbar = new Style();
        toolbar.direction = HORIZONTAL;
        toolbar.height = PX(60, Strength.MEDIUM);
        toolbar.color = 0xff444444;

        var toolbarItem = new Style();
        toolbarItem.height = PERCENT(1, Strength.MEDIUM);
        toolbarItem.width = PX(170, Strength.MEDIUM);
        toolbarItem.color = 0xff888888;

        var mainContent = new Style();
        mainContent.direction = HORIZONTAL;
        mainContent.height = CALC(function(p) {
            return p - 60;
        }, Strength.MEDIUM);
        mainContent.width = PERCENT(1, Strength.MEDIUM);
        mainContent.color = 0xffddffee;

        var leftColumn = new Style();
        leftColumn.direction = VERTICAL;
        leftColumn.height = PERCENT(1, Strength.MEDIUM);
        leftColumn.width = PX(200, Strength.WEAK);
        leftColumn.minWidth = PX(200, Strength.REQUIRED);
        leftColumn.maxWidth = PX(400, Strength.REQUIRED);
        leftColumn.color = 0xff444444;

        var hDivider = new Style();
        hDivider.height = PERCENT(1, Strength.MEDIUM);
        hDivider.width = PX(20, Strength.MEDIUM);
        hDivider.color = 0xffaaaaaa;

        var centerColumn = new Style();
        centerColumn.direction = VERTICAL;
        centerColumn.height = PERCENT(1, Strength.MEDIUM);
        centerColumn.width = CALC(function(p) {
            return p - 420;
        }, Strength.MEDIUM);
        centerColumn.color = 0xff777777;

        var rightColumn = new Style();
        rightColumn.direction = VERTICAL;
        rightColumn.height = PERCENT(1, Strength.MEDIUM);
        rightColumn.width = PX(200, Strength.MEDIUM);
        rightColumn.color = 0xff444444;

        return container(mainContainerStyle,
            [ container(toolbar, 
                [ container(toolbarItem, [])
                , container(toolbarItem, [])
                , container(toolbarItem, [])
                , container(toolbarItem, [])
                ])
            , container(mainContent,
                [ container(leftColumn, 
                    [
                    ])
                , verticalDivider(hDivider, 
                    [
                    ])
                , container(centerColumn, 
                    [
                    ])
                , container(rightColumn, 
                    [
                    ])
                ])
            ]);
    }

}