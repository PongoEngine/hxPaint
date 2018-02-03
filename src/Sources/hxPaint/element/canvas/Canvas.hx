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

package hxPaint.element.canvas;

import jasper.Solver;
import hxPaint.Paint;
import hxPaint.element.canvas.Painter;

using hxPaint.layout.LayoutTools;

class Canvas extends Rectangle
{
    public var operation :PaintOperation;

    public function new(paint :Paint) : Void
    {
        super(paint);
        _painter = new Painter();
        _isDown = false;
        _downX = -1;
        _downY = -1;
        this.operation = INVALID;

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
        _downX = Std.int(x - this.x.m_value);
        _downY = Std.int(y - this.y.m_value);

        switch this.operation {
            case CIRCLE:
            case ERASER: _painter.erase(_downX, _downY);
            case FILL: _painter.fill(_downX, _downY);
            case LINE:
            case PENCIL: _painter.pencil(_downX, _downY);
            case INVALID:
        }
        
        
        _isDown = true;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        var moveX = Std.int(x - this.x.m_value);
        var moveY = Std.int(y - this.y.m_value);

        if(_isDown) {
            switch this.operation {
                case CIRCLE: _painter.drawEllipse(moveX, moveY, _downX, _downY, true);
                case ERASER: _painter.erase(moveX, moveY);
                case FILL:
                case LINE: _painter.drawLine(moveX, moveY, _downX, _downY, true);
                case PENCIL: _painter.pencil(moveX, moveY);
                case INVALID:
            }
        }
    }

    private function onSystemUp(x :Int, y :Int) : Void
    {
        var upX = Std.int(x - this.x.m_value);
        var upY = Std.int(y - this.y.m_value);

        switch this.operation {
            case CIRCLE: _painter.drawEllipse(upX, upY, _downX, _downY, false);
            case ERASER:
            case FILL:
            case LINE: _painter.drawLine(upX, upY, _downX, _downY, false);
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
        
        framebuffer.g2.pushTranslation(x.m_value, y.m_value);
        _painter.draw(framebuffer);
        framebuffer.g2.popTransformation();
    }

    override public function afterSolved() : Void
    {
        _painter.resize(this.width.m_value, this.height.m_value);
    }

    private var _painter :Painter;
    private var _isDown :Bool;
    private var _downX :Int;
    private var _downY :Int;
}