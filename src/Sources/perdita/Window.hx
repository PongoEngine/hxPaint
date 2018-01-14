package perdita;

import perdita.element.Box;

class Window
{
    public function new(color :Int, width :Float, height :Float) : Void
    {
        _root = new Box(new Style());
        _root._constraints = [
            _root._x == 0,
            _root._y == 0,
            _root._width == width,
            _root._height == height
        ];
    }

    @:final public function addBox(child :Box) : Window
    {
        _root.addChild(child);
        return this;
    }
 
    public function render(framebuffer :kha.Framebuffer) : Void
    {
        Box.render(_root, framebuffer);
    }

    public var _root :Box;
}