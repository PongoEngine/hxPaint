package perdita;

import jasper.Variable;
import jasper.Constraint;
import perdita.Style;

@:allow(perdita.Window)
class Box
{
    public var color :Int;
    public var style (default, null):Style;

    public function new(color :Int, style :Style) : Void
    {
        this.color = color;
        this.style = style;

        _x = new Variable();
        _y = new Variable();
        _width = new Variable();
        _height = new Variable();
        _children = [];
        _constraints = [];
    }

    @:final public function addBox(child :Box) : Box
    {
        switch child.style.width {
            case NONE:
            case PX(val): child._constraints.push(child._width == val);
            case PERCENT(val): child._constraints.push(child._width == val * _width);
        }

        switch child.style.height {
            case NONE:
            case PX(val): child._constraints.push(child._height == val);
            case PERCENT(val): child._constraints.push(child._height == val * _height);
        }

        switch child.style.marginTop {
            case NONE:
            case PX(val): child._constraints.push(child._y == _y + val);
            case PERCENT(val): child._constraints.push(child._y == _y + val * _height);
        }

        switch child.style.marginLeft {
            case NONE:
            case PX(val): child._constraints.push(child._x == _x + val);
            case PERCENT(val): child._constraints.push(child._x == _x + val * _width);
        }

        _children.push(child);
        return this;
    }
 
    public function render(graphics :kha.graphics2.Graphics) : Void
    {
        graphics.color = this.color;
        graphics.fillRect(_x.m_value, _y.m_value, _width.m_value, _height.m_value);
        for(c in _children) {
            c.render(graphics);
        }
    }

    private var _x :Variable;
    private var _y :Variable;
    private var _width :Variable;
    private var _height :Variable;

    public var _children :Array<Box>;
    public var _constraints :Array<Constraint>;
}