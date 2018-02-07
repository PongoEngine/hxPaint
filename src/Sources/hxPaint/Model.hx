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

package hxPaint;

import hxPaint.element.canvas.PaintOperation;
import hxPaint.element.canvas.Pixels;
import hxPaint.element.palette.Pallete;
import kha.Color;

class Model
{
    public var operation :PaintOperation;
    public var pencilColor :Color;
    public var fillColor :Color;
    public var lineColor :Color;
    public var circleColor :Color;
    public var palette :Pallete = null;

    public function new() : Void
    {
        this.operation = PENCIL;
        this.pencilColor = Pixels.BLACK;
        this.fillColor = Pixels.BLACK;
        this.lineColor = Pixels.BLACK;
        this.circleColor = Pixels.BLACK;
    }

    public function selectColor(color :Color) : Void
    {
        switch this.operation {
            case CIRCLE: this.circleColor = color;
            case FILL: this.fillColor = color;
            case LINE: this.lineColor = color;
            case PENCIL: this.pencilColor = color;
            case _:
        }
    } 
}