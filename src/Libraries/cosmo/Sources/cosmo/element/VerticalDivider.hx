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

import cosmo.Cosmo;

@:allow(cosmo.Cosmo)
class VerticalDivider extends Element
{
    private function new(cosmo :Cosmo) : Void
    {
        super(VERTICAL_DIVIDER, cosmo);

        _isDown = false;
        this.cosmo.mouse.pointerMove.connect(function(x,y) {
            if(_isDown) {
                var cx = x - _lastX;
                this.cosmo.layout.suggest(this.x, this.x.m_value + cx);
                _lastX = x;
            }
        });

        this.cosmo.mouse.pointerUp.connect(function(x,y) {
            _isDown = false;
        });

        this.cosmo.mouse.pointerDown.connect(function(x,y) {
            if(this.cosmo.mouse.isHit(this, x, y)) {
                _isDown = true;
                _lastX = x;
            }
        });
    }

    private var _isDown :Bool;
    private var _lastX :Int;

}