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

package hxPaint.element;

import jasper.Solver;
import jasper.Strength;
import hxPaint.Paint;

using hxPaint.layout.LayoutTools;

class LeftColumn extends Rectangle
{
    public function new(paint :Paint) : Void
    {
        super(paint);
        _isShrunk = false;

        _isComplete = true;
        _elapsed = 0;
    }

    override public function update(dt :Float) : Void
    {
        if(_isComplete)  return;

        _elapsed += dt;

        if(_elapsed >= DURATION) {
            _isComplete = true;
            handleSize(50);
        }
        else {
            var size = elasticOut(_elapsed/DURATION) * 50;
            handleSize(size);
        }
    }

    private function handleSize(size :Float) : Void
    {
        if(_isShrunk) {
            paint.suggest(this.width, 90 - size);
        }
        else {
            paint.suggest(this.width, 40 + size);
        }
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.left() == parent.left());
        solver.addConstraint(this.top() == parent.top());
        solver.addConstraint(this.height == parent.height);
        solver.addEditVariable(this.width, Strength.STRONG);
        solver.suggestValue(this.width, 90);
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        trace(x,y);

        _isComplete = false;
        _elapsed = 0;
        _isShrunk = !_isShrunk;
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xffaaccbb;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value,1);
    }

    public static function elasticOut (t :Float) :Float
    {
        return (1 * Math.pow(2, -10 * t) * Math.sin((t - (0.4 / (3.141592653589793*2) * Math.asin(1 / 1))) * (3.141592653589793*2) / 0.4) + 1);
    }

    private var _isShrunk : Bool;

    private var _isComplete :Bool;
    private var _elapsed :Float;
    private static inline var DURATION = 1.5;
}