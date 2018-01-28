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
import cosmo.renderer.Renderer;
import cosmo.layout.Layout;
import jasper.Solver;

import cosmo.style.DefaultStyler;

class Cosmo
{
    public var window (default, null) :Window;
    public var solver (default, null) :Solver;
    public var mouse (default, null) :Mouse;
    public var layout (default, null) :Layout;

    public function new() : Void
    {
        this.window = new Window();
        this.solver = new Solver();
        this.mouse = new Mouse();
        this.layout = new Layout();
    }

    public function render(framebuffer :kha.Framebuffer) : Void
    {
        Renderer.render(window, framebuffer);
    }

    public static function createElement(elementType :ElementType) : Element
    {
        return DefaultStyler.setStyle(switch elementType {
            case ELEMENT: new Element(ELEMENT);
            case CONTAINER: new Container();
            case BUTTON: new Button();
            case VERTICAL_DIVIDER: new VerticalDivider();
            case WINDOW: new Window();
        });
    }
}