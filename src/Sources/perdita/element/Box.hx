package perdita.element;

import jasper.Variable;
import jasper.Constraint;
import perdita.Style;

@:allow(perdita.Window)class Box
{
    public var style (default, null):Style;
    public var firstChild (default, null) :Box = null;
    public var next (default, null) :Box = null;
    public var prev (default, null) :Box = null;

    public function new(style :Style) : Void
    {
        this.style = style;

        _x = new Variable();
        _y = new Variable();
        _width = new Variable();
        _height = new Variable();
        _constraints = [];
    }

    public function addChild (child :Box) :Box
    {
        var tail = null, p = firstChild;

        while (p != null) {
            tail = p;
            p = p.next;
        }

        if (tail != null) {
            tail.next = child;
            child.prev = tail;
        } else {
            firstChild = child;
        }

        setConstraints(child);
        return this;
    }

    public function setConstraints(child :Box) : Void
    {
        switch child.style.width {
            case INHERIT:
            case PX(val): child._constraints.push(child._width == val);
            case PERCENT(val): child._constraints.push(child._width == val * _width);
            case CALC(expressionFn): child._constraints.push(child._width == expressionFn(_width));
        }

        switch child.style.height {
            case INHERIT:
            case PX(val): child._constraints.push(child._height == val);
            case PERCENT(val): child._constraints.push(child._height == val * _height);
            case CALC(expressionFn): child._constraints.push(child._height == expressionFn(_height));
        }

        if(child.prev == null) {
            child._constraints.push(child._x == _x);
        }
        else {
            child._constraints.push(child._x == (child.prev._x + child.prev._width));
        }

        child._constraints.push(child._y == _y);
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
    }

    public static function render (box :Box, framebuffer :kha.Framebuffer)
    {
        box.draw(framebuffer);

        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            render(p, framebuffer);
            p = next;
        }
    }

    private var _x :Variable;
    private var _y :Variable;
    private var _width :Variable;
    private var _height :Variable;

    public var _constraints :Array<Constraint>;
}