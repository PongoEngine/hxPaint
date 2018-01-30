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
import jasper.Solver;

using cosmo.layout.LayoutTools;

class Layout
{
    public function new() : Void
    {
        _solver = new Solver();
    }

    public function layout(element :Element) : Void
    {
        layout_impl(element);
        _solver.updateVariables();
    }

    private function layout_impl(element :Element) : Void
    {
        constraintStyle(element);

        var p = element.firstChild;
        if(p != null) {
            constraintFirstChild(p);
            layout_impl(p);
            p = p.nextSibling;
        }
        while (p != null) {
            var next = p.nextSibling;
            layout_impl(p);
            if(next == null) {
                constraintLast(p);
            }
            else {
                constraintMiddle(p);
            }
            p = next;
        }
    }

    private function constraintFirstChild(element :Element) : Void
    {
        trace("constraintFirstChild");
        _solver.medium(element.left() == element.parentElement.left());
    }

    private function constraintLast(element :Element) : Void
    {
        trace("constraintLast");
        _solver.medium(element.left() == element.prevSibling.right());
        _solver.required(element.parentElement.right() >= element.right());
    }

    private function constraintMiddle(element :Element) : Void
    {
        trace("constraintMiddle");
        _solver.medium(element.left() == element.prevSibling.right());
    }

    private function constraintStyle(element :Element) : Void
    {
        switch element.style.width {
            case PX(val): _solver.medium(element.width == val);
            case INHERIT: _solver.weak(element.width == 0);
        }

        switch element.style.height {
            case PX(val): _solver.medium(element.height == val);
            case INHERIT: _solver.weak(element.height == 0);
        }
    }

    @:allow(cosmo.Cosmo)
    private var _solver :Solver;
}