package cosmo.element;

import cosmo.style.Style;
import cosmo.layout.LayoutDefs.*;

class VerticalDivider extends Element
{
    public function new(style :Style) : Void
    {
        super(style, VERTICAL_DIVIDER);
        _isDown = false;
        _xVal = 0;
    }

    override public function onAdded() : Void
    {
        Cosmo.solver.addEditVariable(this.x, EDIT_STRENGTH);

        Cosmo.pointerDown.connect(function(x,y) {
            if(Cosmo.isHit(this,x,y)) {
                _isDown = true;
                _xVal = x;
            }
        });

        Cosmo.pointerUp.connect(function(_,_) {
            _isDown = false;
        });

        Cosmo.pointerMove.connect(function(x,y) {
            if(_isDown) {
                var change = x - _xVal;
                Cosmo.solver.suggestValue(this.x, this.x.m_value + change);
                Cosmo.solver.updateVariables();
                _xVal = x;
            }
        });
    }

    override public function onRemoved() : Void
    {
        Cosmo.solver.removeEditVariable(this.x);
    }

    private var _isDown :Bool;
    private var _xVal :Float;
}