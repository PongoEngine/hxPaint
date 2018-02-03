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

package hxPaint.input;

import hxPaint.element.Window;
import hxPaint.element.Rectangle;

class Mouse
{
    public function new(window :Window) : Void
    {
        initMouse(window);
        _upConnections = [];
    }

    public function connectUp(fn :Int -> Int -> Void) : Void
    {
        _upConnections.push(fn);
    }

    private static function hitTest_impl(rectangle :Rectangle, x :Int, y :Int, type :HitType) : Bool
    {
        var wasHit = isHit(rectangle,x,y);

        var isChildHit = false;
        var index = rectangle.children.length;
        while(index --> 0) {
            var child = rectangle.children[index];
            if(hitTest_impl(child, x, y, type)) {
                isChildHit = true;
                break;
            }
        }

        if(!isChildHit && wasHit) {
            switch type {
                case DOWN: rectangle.onDown(x,y);
                case UP: rectangle.onUp(x,y);
                case MOVE: rectangle.onMove(x,y);
            }
        }

        return wasHit || isChildHit;
    }

    public static inline function isHit(rectangle :Rectangle, x :Int, y :Int) : Bool
    {
        var minX = rectangle.x.m_value;
        var maxX = rectangle.width.m_value + minX;
        var minY = rectangle.y.m_value;
        var maxY = rectangle.height.m_value + minY;
        
        return
            minX <= x && maxX >= x &&
            minY <= y && maxY >= y;
    }

    private function initMouse(window :Window) : Void
    {
        kha.input.Mouse.get().notify(function(button,x,y) {
            hitTest_impl(window, x, y, DOWN);
        }, function(button,x,y) {
            hitTest_impl(window, x, y, UP);
            for(c in _upConnections) {
                c(x,y);
            }
        }, function(x, y, cX, cY) {
            hitTest_impl(window, x, y, MOVE);
        }, function(w) {

        });
    }

    private var _upConnections :Array<Int -> Int -> Void>;
}

@:enum
abstract HitType(Int)
{
    var DOWN = 0;
    var UP = 1;
    var MOVE = 2;
}