package cosmo.element;

import jasper.Strength;
import cosmo.style.Style;

class HorizontalDivider extends Element
{
    public function new(style :Style) : Void
    {
        super(style);
        _isDown = false;
        _yVal = 0;
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        _isDown = true;
        _yVal = y;
    }

    override public function onAdded() : Void
    {
        Cosmo.solver.addEditVariable(this.y, Strength.MEDIUM);
        Cosmo.pointerUp.connect(function(_,_) {
            _isDown = false;
        });

        Cosmo.pointerMove.connect(function(x,y) {
            if(_isDown) {
                var change = y - _yVal;
                Cosmo.solver.suggestValue(this.y, this.y.m_value + change);
                Cosmo.solver.updateVariables();
                _yVal = y;
            }
        });
    }

    override public function onRemoved() : Void
    {
        Cosmo.solver.removeEditVariable(this.y);
    }

    private var _isDown :Bool;
    private var _yVal :Float;
}