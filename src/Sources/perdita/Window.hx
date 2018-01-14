package perdita;

class Window
{
    public function new(color :Int, width :Float, height :Float) : Void
    {
        _root = new Box(color, new Style());
        _root._constraints = [
            _root._x == 0,
            _root._y == 0,
            _root._width == width,
            _root._height == height
        ];
    }

    @:final public function addBox(child :Box) : Window
    {
        _root.addBox(child);
        return this;
    }
 
    public function render(graphics :kha.graphics2.Graphics) : Void
    {
        _root.render(graphics);
    }

    public var _root :Box;
}