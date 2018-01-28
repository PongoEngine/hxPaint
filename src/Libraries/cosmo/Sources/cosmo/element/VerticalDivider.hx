/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package cosmo.element;

import cosmo.layout.LayoutDefs.*;

class VerticalDivider extends Element
{
    public function new() : Void
    {
        super(VERTICAL_DIVIDER);
        _isDown = false;
        _xVal = 0;
    }

    override public function onAdded() : Void
    {
        Cosmo.solver.addEditVariable(this.x, EDIT_STRENGTH);

        Cosmo.mouse.pointerDown.connect(function(x,y) {
            if(Cosmo.mouse.isHit(this,x,y)) {
                _isDown = true;
                _xVal = x;
            }
        });

        Cosmo.mouse.pointerUp.connect(function(_,_) {
            _isDown = false;
        });

        Cosmo.mouse.pointerMove.connect(function(x,y) {
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