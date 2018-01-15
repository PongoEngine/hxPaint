package perdita.element;

import jasper.Variable;
import jasper.Strength;
import jasper.Constraint;
import perdita.Style;

@:allow(perdita.Window)class Box
{
    public var style (default, null):Style;
    public var firstChild (default, null) :Box = null;
    public var next (default, null) :Box = null;
    public var prev (default, null) :Box = null;
    public var name :String;

    public function new(name :String = "", style :Style) : Void
    {
        this.name = name;
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
        }

        switch child.style.height {
            case INHERIT:
            case PX(val): child._constraints.push(child._height == val);
            case PERCENT(val): child._constraints.push(child._height == val * _height);
        }

        child._constraints.push((child._x >= _x) | Strength.WEAK);
        
        if(child.prev != null) {
            child._constraints.push((child._x == (child.prev._x + child.prev._width)) | Strength.MEDIUM);
            child._constraints.push(((child._x + child._width) <= _width) | Strength.REQUIRED);
        }

        // if(child.prev == null) {
        //     child._constraints.push((child._y == _y) | Strength.WEAK);
        // }
        // else {
        //     child._constraints.push((child._y == _y) | Strength.MEDIUM);
        //     child._constraints.push((child._y == (child.prev._y + child.prev._height)) | Strength.WEAK);
        // }

        
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

    public var _x :Variable;
    public var _y :Variable;
    public var _width :Variable;
    public var _height :Variable;

    public var _constraints :Array<Constraint>;
}