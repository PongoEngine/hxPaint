package cosmo.element;

import jasper.Variable;
import jasper.Constraint;
import cosmo.style.Style;
import cosmo.layout.Layout;

class Element
{
    public var firstChild (default, null) : Element = null;
    public var prevSibling (default, null) : Element = null;
    public var nextSibling (default, null) : Element = null;
    public var parentElement (default, null) : Element = null;
    public var elementType (default, null) : ElementType;

    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;
    public var style :Style;

    public function new(style :Style, elementType :ElementType) : Void
    {
        x = new Variable();
        y = new Variable();
        width = new Variable();
        height = new Variable();
        this.style = style;
        this.elementType = elementType;
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = style.color;
        framebuffer.g2.fillRect(x, y, width, height);
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x, y, width, height, 2);
    }

    public function onAdded() : Void
    {
    }

    public function onRemoved() : Void
    {
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

        child.onAdded();
        Layout.layout(child);
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
                child.clean();
                child.onRemoved();
                return;
            }
            prev = p;
            p = nextSibling;
        }
    }

    public function replaceChild(newChild :Element, oldChild :Element) : Void
    {
        // if (newChild.parentElement != null) {
        //     newChild.parentElement.removeChild(newChild);
        // }
        // newChild.parentElement = this;

        // var prev :Element = null, p = firstChild;
        // while (p != null) {
        //     var nextSibling = p.nextSibling;
        //     if (p == oldChild) {
        //         // Splice out the entity
        //         if (prev == null) {
        //             firstChild = newChild;
        //         } else {
        //             prev.nextSibling = newChild;
        //         }
        //         newChild.nextSibling = nextSibling;
        //         newChild.parentElement = this;

        //         p.parentElement = null;
        //         p.nextSibling = null;
 
        //         swapVars(newChild, oldChild);
        //         return;
        //     }

        //     prev = p;
        //     p = nextSibling;
        // }
    }

    private function clean() : Void
    {
        for(c in _constraints) {
            Cosmo.solver.removeConstraint(c);
        }
        _constraints = [];
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

    @:allow(cosmo.layout)
    private var _constraints :Array<Constraint> = [];
}