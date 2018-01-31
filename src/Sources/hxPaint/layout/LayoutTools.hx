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

package hxPaint.layout;

import jasper.Expression;
import hxPaint.element.Rectangle;

class LayoutTools
{
    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function left(rectangle :Rectangle) : Expression
    {
        return rectangle.x + 0;
    }

    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function right(rectangle :Rectangle) : Expression
    {
        return rectangle.x + rectangle.width;
    }

    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function top(rectangle :Rectangle) : Expression
    {
        return rectangle.y + 0;
    }

    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function bottom(rectangle :Rectangle) : Expression
    {
        return rectangle.y + rectangle.height;
    }

    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function centerX(rectangle :Rectangle) : Expression
    {
        return rectangle.x + rectangle.width/2;
    }

    /**
     *  [Description]
     *  @param rectangle - 
     *  @return Expression
     */
    @:extern public static inline function centerY(rectangle :Rectangle) : Expression
    {
        return rectangle.y + rectangle.height/2;
    }
}