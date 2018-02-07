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

package hxPaint.element.palette;

import jasper.Solver;
import hxPaint.Paint;
import kha.Color;

using hxPaint.layout.LayoutTools;

class ColorOption extends Rectangle
{
    public function new(paint :Paint, color :Int) : Void
    {
        super(paint);
        _color = color;
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
        framebuffer.g2.color = _color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);

        var isSelected = switch this.paint.model.operation {
            case CIRCLE: this.paint.model.circleColor == _color;
            case FILL: this.paint.model.fillColor == _color;
            case LINE: this.paint.model.lineColor == _color;
            case PENCIL: this.paint.model.pencilColor == _color;
            case _: false;
        }

        if(isSelected) {
            framebuffer.g2.color = 0xffffffff;
            framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value, 2);
        }
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        this.paint.model.selectColor(_color);
    }

    private var _color :Color;
}