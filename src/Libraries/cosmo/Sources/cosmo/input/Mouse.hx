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

package cosmo.input;

import cosmo.util.Signal2;
import cosmo.element.Element;

class Mouse
{
    public var pointerDown (default, null) :Signal2<Int, Int>;
    public var pointerUp (default, null) :Signal2<Int, Int>;
    public var pointerMove (default, null) :Signal2<Int, Int>;

    public function new() : Void
    {
        pointerDown = new Signal2();
        pointerUp = new Signal2();
        pointerMove = new Signal2();
        init();
    }

    public function isHit(box :Element, x :Int, y :Int) : Bool
    {
        var minX = box.x.m_value;
        var maxX = box.width.m_value + minX;
        var minY = box.y.m_value;
        var maxY = box.height.m_value + minY;
        
        return
            minX <= x && maxX >= x &&
            minY <= y && maxY >= y;
    }

    private inline function init() : Void
    {
        kha.input.Mouse.get().notify(function(button,x,y) {
            pointerDown.emit(x,y);
        }, function(button,x,y) {
            pointerUp.emit(x,y);
        }, function(x, y, cX, cY) {
            pointerMove.emit(x,y);
        }, function(w) {

        });
    }
}