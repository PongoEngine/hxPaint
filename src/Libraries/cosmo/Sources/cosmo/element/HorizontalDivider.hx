package cosmo.element;

import cosmo.style.Style;

class HorizontalDivider extends Element
{
    public function new(style :Style) : Void
    {
        super(style);
        _isDown = false;
        _xVal = 0;
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        _isDown = false;
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        _isDown = true;
        _xVal = x;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            var change = x - _xVal;
            trace(change);
            _xVal = x;
        }
    }

    private var _isDown :Bool;
    private var _xVal :Float;
}