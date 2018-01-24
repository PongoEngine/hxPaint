package cosmo.element;

import jasper.Strength;
import cosmo.style.Style;

class HorizontalDivider extends Element
{
    public function new(style :Style) : Void
    {
        super(style);
        _isDown = false;
        _xVal = 0;
        trace("wdjfskldfj");
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

    override public function onAdded() : Void
    {
        Cosmo.solver.addEditVariable(this.x, Strength.STRONG);
    }

    override public function onRemoved() : Void
    {
        Cosmo.solver.removeEditVariable(this.x);
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            var change = x - _xVal;
            Cosmo.solver.suggestValue(this.x, this.x.m_value + change);
            Cosmo.solver.updateVariables();
            _xVal = x;
        }
    }

    private var _isDown :Bool;
    private var _xVal :Float;
}