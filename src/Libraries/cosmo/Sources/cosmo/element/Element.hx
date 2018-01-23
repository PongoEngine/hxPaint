package cosmo.element;

import jasper.Variable;
import jasper.Solver;
import cosmo.style.Style;

class Element
{
    public var firstChild (default, null) : Element;
    public var nextSibling (default, null) : Element;
    public var parentElement (default, null) : Element;

    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;
    public var style :Style;

    public function new(style :Style) : Void
    {
        x = new Variable();
        y = new Variable();
        width = new Variable();
        height = new Variable();
        this.style = style;
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
    }

    public function onUp(x :Int, y :Int) : Void
    {
    }

    public function onDown(x :Int, y :Int) : Void
    {
    }

    public function onMove(x :Int, y :Int) : Void
    {
    }

    public function appendChild(child :Element) : Element
    {
        if (child.parentElement != null) {
            child.parentElement.removeChild(child);
        }
        child.parentElement = this;
        child.layout(this);

        var tail = null, p = firstChild;
        while (p != null) {
            tail = p;
            p = p.nextSibling;
        }
        if (tail != null) {
            tail.nextSibling = child;
        } else {
            firstChild = child;
        }

        return this;
    }

    public function removeChild(child :Element) : Void
    {
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
 
                swapVars(newChild, oldChild);
                return;
            }

            prev = p;
            p = nextSibling;
        }
    }

    private function layout(parent :Element) : Void
    {

    }

    private function swapVars(newChild :Element, oldChild :Element) : Void
    {
        var newChildX = newChild.x;
        var newChildY = newChild.y;
        var newChildWidth = newChild.width;
        var newChildHeight = newChild.height;

        newChild.x = oldChild.x;
        newChild.y = oldChild.y;
        newChild.width = oldChild.width;
        newChild.height = oldChild.height;

        oldChild.x = newChildX;
        oldChild.y = newChildY;
        oldChild.width = newChildWidth;
        oldChild.height = newChildHeight;
    }
}