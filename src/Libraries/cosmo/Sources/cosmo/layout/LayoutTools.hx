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

package cosmo.layout;

import cosmo.element.Element;
import jasper.Expression;

class LayoutTools
{
    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function left(element :Element) : Expression
    {
        return element.x + 0;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function right(element :Element) : Expression
    {
        return element.x + element.width;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function top(element :Element) : Expression
    {
        return element.y + 0;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function bottom(element :Element) : Expression
    {
        return element.y + element.height;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function centerX(element :Element) : Expression
    {
        return element.x + element.width/2;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function centerY(element :Element) : Expression
    {
        return element.y + element.height/2;
    }
}