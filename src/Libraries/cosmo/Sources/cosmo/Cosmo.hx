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

package cosmo;

import cosmo.element.*;
import cosmo.input.Mouse;
import jasper.Solver;
import jasper.Strength;

class Cosmo
{
    public var root (default, null) :Element;
    public static var solver (default, null) :Solver;
    public static var mouse (default, null) :Mouse;

    public function new() : Void
    {
        this.root = new Element(ELEMENT);

        Cosmo.solver = new Solver();
        Cosmo.solver.addConstraint(this.root.x == 0);
        Cosmo.solver.addConstraint(this.root.y == 0);
        Cosmo.solver.addConstraint((this.root.width == kha.System.windowWidth()) | Strength.WEAK);
        Cosmo.solver.addConstraint((this.root.height == kha.System.windowHeight()) | Strength.WEAK);

        Cosmo.mouse = new Mouse();
    }

    public function render(framebuffer :kha.Framebuffer) : Void
    {
        render_impl(root, framebuffer);
    }

    public static function createElement(elementType :ElementType) : Element
    {
        return switch elementType {
            case ELEMENT: new Element(ELEMENT);
            case CONTAINER: new Container();
            case BUTTON: new Button();
            case VERTICAL_DIVIDER: new VerticalDivider();
        }
    }

    private static function render_impl(box :Element, framebuffer :kha.Framebuffer)
    {
        box.draw(framebuffer);

        var p = box.firstChild;
        while (p != null) {
            var next = p.nextSibling;
            render_impl(p, framebuffer);
            p = next;
        }
    }
}