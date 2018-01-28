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

import jasper.Constraint;
import cosmo.element.Element;
import cosmo.layout.LayoutDefs.*;

using cosmo.layout.LayoutTools;

class LayoutHorizontal
{
    public static function layout(element :Element) : Void
    {
        var constraints = element._constraints;
        var parent = element.parentElement;

        layoutWidth(element, parent, constraints);

        layoutHeight(element, parent, constraints);
        layoutX(element, parent, constraints);
        layoutY(element, parent, constraints);
    }

    public static inline function layoutWidth(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch [element.style.width, element.elementType] {
            case [INHERIT, _]: constraints.push((element.width == 0) | INHERIT_STRENGTH);
            case [PX(val), VERTICAL_DIVIDER]: constraints.push((element.width == val) | REQUIRED_STRENGTH);
            case [PX(val), _]: constraints.push((element.width == val) | PX_STRENGTH);
        }
        constraints.push((element.width >= 0) | REQUIRED_STRENGTH);
    }

    public static inline function layoutHeight(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.height {
            case INHERIT: constraints.push((element.height == parent.height) | INHERIT_STRENGTH);
            case PX(val): constraints.push((element.height == val) | PX_STRENGTH);
        }
        constraints.push((element.height >= 0) | REQUIRED_STRENGTH);
    }

    public static inline function layoutX(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        if(element.prevSibling == null) {
            switch element.style.x {
                case INHERIT: {
                    constraints.push((element.left() == parent.left()) | REQUIRED_STRENGTH);
                }
                case PX(val):
            }
        }
        else {
            var prevSib = element.prevSibling;
            switch element.style.x {
                case INHERIT: {
                    constraints.push((element.left() == prevSib.right()) | INHERIT_STRENGTH);
                    constraints.push((element.left() >= prevSib.right()) | REQUIRED_STRENGTH);
                }
                case PX(val): 
            }
        }
        // constraints.push((element.right() <= parent.right()) | REQUIRED_STRENGTH);
    }

    public static inline function layoutY(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.y {
            case INHERIT: constraints.push((element.top() == parent.top()) | REQUIRED_STRENGTH);
            case PX(val): constraints.push((element.top() == parent.top() + val) | REQUIRED_STRENGTH);
        }
    }
}