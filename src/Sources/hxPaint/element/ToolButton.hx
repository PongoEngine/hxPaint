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
import hxPaint.element.canvas.PaintOperation;

using hxPaint.layout.LayoutTools;

class ToolButton extends Rectangle
{
    public function new(paint :Paint, title :String, operation : PaintOperation) : Void
    {
        super(paint);
        _title = title;
        _operation = operation;

        _width = kha.Assets.fonts.Roboto_Black.width(12, _title);
        _height = kha.Assets.fonts.Roboto_Black.height(12);
    }

    override public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
        solver.addConstraint(this.left() == parent.left() + 5);
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == this.width);

        if(prevSibling == null) {
            solver.addConstraint(this.top() == parent.top() + 5);
        }
        else {
            solver.addConstraint(this.top() == prevSibling.bottom() + 5);
        }
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff212121;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);

        framebuffer.g2.color = 0xffffffff;
        framebuffer.g2.fontSize = 12;
        var centerX = x.m_value - _width/2 + width.m_value/2;
        var centerY = y.m_value - _height/2 + height.m_value/2;
        framebuffer.g2.drawString(_title, centerX, centerY);
        framebuffer.g2.fontSize = 18;

        if(this._operation == paint.model.operation) {
            framebuffer.g2.color = switch this._operation {
                case CIRCLE: this.paint.model.circleColor;
                case FILL: this.paint.model.fillColor;
                case LINE: this.paint.model.lineColor;
                case PENCIL: this.paint.model.pencilColor;
                case _: 0xffb2dfdb;
            }
            framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value, 8);
        }
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        if(paint.model.operation == _operation) {
            turnOff();
        }
        else {
            turnOn();
        }
    }

    public function turnOn() : Void
    {
        paint.model.operation = _operation;
    }

    public function turnOff() : Void
    {
        paint.model.operation = INVALID;
    }

    private var _isOn :Bool;
    private var _title :String;
    private var _operation :PaintOperation;
    private var _width :Float;
    private var _height :Float;
}