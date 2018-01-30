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

package cosmo.element;

import jasper.Variable;
import cosmo.style.Style;
import cosmo.Cosmo;

@:allow(cosmo.Cosmo)
class Element
{
    public var firstChild (default, null) : Element = null;
    public var prevSibling (default, null) : Element = null;
    public var nextSibling (default, null) : Element = null;
    public var parentElement (default, null) : Element = null;
    public var elementType (default, null) : ElementType;
    public var cosmo (default, null) : Cosmo;

    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;
    public var style :Style;

    private function new(elementType :ElementType, cosmo :Cosmo) : Void
    {
        x = new Variable();
        y = new Variable();
        width = new Variable();
        height = new Variable();
        style = new Style();
        this.elementType = elementType;
        this.cosmo = cosmo;
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xffffffff;
        framebuffer.g2.fillRect(x, y, width, height);
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x, y, width, height, 2);
    }

    public function appendChild(child :Element) : Element
    {
        if (child.parentElement != null) {
            child.parentElement.removeChild(child);
        }
        child.parentElement = this;

        var tail = null, p = firstChild;
        while (p != null) {
            tail = p;
            p = p.nextSibling;
        }
        if (tail != null) {
            tail.nextSibling = child;
            child.prevSibling = tail;
        } else {
            firstChild = child;
        }

        return this;
    }

    public function removeChild(child :Element) : Void
    {
        throw "add prevSibling";
        var prev :Element = null, p = firstChild;
        while (p != null) {
            var nextSibling = p.nextSibling;
            if (p == child) {
                // Splice out the entity
                if (prev == null) {
                    firstChild = nextSibling;
                } else {
                    prev.nextSibling = nextSibling;
                }
                p.parentElement = null;
                p.nextSibling = null;
                return;
            }
            prev = p;
            p = nextSibling;
        }
    }

    public function replaceChild(newChild :Element, oldChild :Element) : Void
    {
        throw "add prevSibling";
        if (newChild.parentElement != null) {
            newChild.parentElement.removeChild(newChild);
        }
        newChild.parentElement = this;

        var prev :Element = null, p = firstChild;
        while (p != null) {
            var nextSibling = p.nextSibling;
            if (p == oldChild) {
                // Splice out the entity
                if (prev == null) {
                    firstChild = newChild;
                } else {
                    prev.nextSibling = newChild;
                }
                newChild.nextSibling = nextSibling;
                newChild.parentElement = this;

                p.parentElement = null;
                p.nextSibling = null;
 
                return;
            }

            prev = p;
            p = nextSibling;
        }
    }
}