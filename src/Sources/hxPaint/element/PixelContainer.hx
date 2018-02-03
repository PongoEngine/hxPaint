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
import hxPaint.Paint;
import hxPaint.canvas.Canvas;

using hxPaint.layout.LayoutTools;

class PixelContainer extends Rectangle
{
    public function new(paint :Paint) : Void
    {
        super(paint);
        _canvas = new Canvas();
        _isDown = false;
        _downX = -1;
        _downY = -1;

        paint.mouse.connectUp(onSystemUp);
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.left() == prevSibling.right());
        solver.addConstraint(this.top() == parent.top());
        solver.addConstraint(this.width == parent.width - prevSibling.width);
        solver.addConstraint(this.height == parent.height);
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        switch this.paint.operation {
            case CIRCLE:
            case ERASER: _canvas.erase(this.x.m_value, this.y.m_value, x, y);
            case FILL: _canvas.fill(this.x.m_value, this.y.m_value, x, y);
            case LINE:
            case PENCIL: _canvas.pencil(this.x.m_value, this.y.m_value, x, y);
            case INVALID:
        }
        
        _downX = x;
        _downY = y;
        _isDown = true;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            switch this.paint.operation {
                case CIRCLE: _canvas.drawEllipse(this.x.m_value, this.y.m_value, _downX, _downY, x, y, true);
                case ERASER: _canvas.erase(this.x.m_value, this.y.m_value, x, y);
                case FILL:
                case LINE: _canvas.drawLine(this.x.m_value, this.y.m_value, _downX, _downY, x, y, true);
                case PENCIL: _canvas.pencil(this.x.m_value, this.y.m_value, x, y);
                case INVALID:
            }
        }
    }

    private function onSystemUp(x :Int, y :Int) : Void
    {
        switch this.paint.operation {
            case CIRCLE: _canvas.drawEllipse(this.x.m_value, this.y.m_value, _downX, _downY, x, y, false);
            case ERASER:
            case FILL:
            case LINE: _canvas.drawLine(this.x.m_value, this.y.m_value, _downX, _downY, x, y, false);
            case PENCIL:
            case INVALID:
        }

        _downX = -1;
        _downY = -1;
        _isDown = false;
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xffeeeeee;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        
        _canvas.draw(x.m_value, y.m_value, framebuffer);
    }

    override public function afterSolved() : Void
    {
        _canvas.resize(this.width.m_value, this.height.m_value);
    }

    private var _canvas :Canvas;
    private var _isDown :Bool;
    private var _downX :Int;
    private var _downY :Int;
}