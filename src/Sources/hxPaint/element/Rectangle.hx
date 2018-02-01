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

import jasper.Variable;
import hxPaint.Paint;

class Rectangle
{
    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;
    public var children :Array<Rectangle>;
    public var paint :Paint;

    public function new(paint :Paint) : Void
    {
        this.paint = paint;
        this.x = new Variable();
        this.y = new Variable();
        this.width = new Variable();
        this.height = new Variable();
        this.children = [];
    }

    public function addChild(child :Rectangle) : Rectangle
    {
        children.push(child);
        return this;
    }

    public function update(dt :Float) : Void
    {
    }

    public function afterSolved() : Void
    {
    }

    public function solve(solver :jasper.Solver, parent :Rectangle, prevSibling :Rectangle) : Void
    {
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
    }

    public function onDown(x :Int, y :Int) : Void
    {
    }

    public function onMove(x :Int, y :Int) : Void
    {
    }

    public function onUp(x :Int, y :Int) : Void
    {
    }

    public function getAll<T:Rectangle>(classType :Class<Dynamic>) : Array<T>
    {
        var rectangles :Array<T> = [];
        getAll_impl(this, classType, rectangles);
        return rectangles;
    }

    private static function getAll_impl<T:Rectangle>(rectangle :Rectangle, classType :Class<Dynamic>, rectangles :Array<T>) : Void
    {
        for(c in rectangle.children) {
            if(Type.getClass(c) == classType) {
                rectangles.push(cast c);
            }
        }

        for(child in rectangle.children) {
            getAll_impl(child, classType, rectangles);
        }
    }
}