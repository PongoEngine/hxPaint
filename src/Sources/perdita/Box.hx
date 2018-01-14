package perdita;

import jasper.Variable;
import jasper.Constraint;
import perdita.Style;

@:allow(perdita.Window)
@:final class Box
{
    public var color :Int;
    public var style (default, null):Style;
    public var parent (default, null) :Box = null;
    public var firstChild (default, null) :Box = null;
    public var next (default, null) :Box = null;

    public function new(color :Int, style :Style) : Void
    {
        this.color = color;
        this.style = style;

        _x = new Variable();
        _y = new Variable();
        _width = new Variable();
        _height = new Variable();
        _constraints = [];
    }

    public function addChild (child :Box, append :Bool=true) :Box
    {
        if (child.parent != null) {
            child.parent.removeChild(child);
        }
        child.parent = this;

        if (append) {
            // Append it to the child list
            var tail = null, p = firstChild;
            while (p != null) {
                tail = p;
                p = p.next;
            }
            if (tail != null) {
                tail.next = child;
            } else {
                firstChild = child;
            }

        } else {
            // Prepend it to the child list
            child.next = firstChild;
            firstChild = child;
        }

        setConstraints(child);
        return this;
    }

    public function removeChild (entity :Box) : Void
    {
        var prev :Box = null, p = firstChild;
        while (p != null) {
            var next = p.next;
            if (p == entity) {
                // Splice out the entity
                if (prev == null) {
                    firstChild = next;
                } else {
                    prev.next = next;
                }
                p.parent = null;
                p.next = null;
                return;
            }
            prev = p;
            p = next;
        }
    }

    public function setConstraints(child :Box) : Void
    {
        switch child.style.width {
            case NONE:
            case PX(val): child._constraints.push(child._width == val);
            case PERCENT(val): child._constraints.push(child._width == val * _width);
            case CALC(expressionFn): child._constraints.push(child._width == expressionFn(_width));
        }

        switch child.style.height {
            case NONE:
            case PX(val): child._constraints.push(child._height == val);
            case PERCENT(val): child._constraints.push(child._height == val * _height);
            case CALC(expressionFn): child._constraints.push(child._height == expressionFn(_height));
        }
    }

    public static function render (box :Box, graphics :kha.graphics2.Graphics)
    {
        graphics.color = box.color;
        graphics.fillRect(box._x.m_value, box._y.m_value, box._width.m_value, box._height.m_value);

        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            render(p, graphics);
            p = next;
        }
    }

    private var _x :Variable;
    private var _y :Variable;
    private var _width :Variable;
    private var _height :Variable;

    public var _constraints :Array<Constraint>;
}