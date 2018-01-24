package wanda.program;

import cosmo.style.Style;
import cosmo.element.Element;
import wanda.virtual.Virtual;
import wanda.virtual.VElement;

class Program<Model, Msg>
{
    public function new(model :Model, updateFn :Msg -> Model -> Void, viewFn : Model -> VElement) : Void
    {
        _model = model;
        _updateFn = updateFn;
        _viewFn = viewFn;

        _oldView = null;
        _root = new Element(new Style());
        Element.solver.addConstraint(_root.x == 0);
        Element.solver.addConstraint(_root.y == 0);
        processView(_model);
    }

    public function update(msg :Msg) : Void
    {
        _updateFn(msg, _model);
        processView(_model);
    }

    public function render(framebuffer :kha.Framebuffer) : Void
    {
        render_impl(_root, framebuffer);
    }

    private function processView(model :Model) : Void
    {
        var nView = _viewFn(_model);
        var hasChanged = Virtual.updateElement(update, _root, nView, _oldView, _root.firstChild);
        _oldView = nView;

        // update_impl(_root, model);
    }

    public static function render_impl(box :Element, framebuffer :kha.Framebuffer)
    {
        box.draw(framebuffer);

        var p = box.firstChild;
        while (p != null) {
            var next = p.nextSibling;
            render_impl(p, framebuffer);
            p = next;
        }
    }

    public static function hitTest_impl(box :Element, x :Int, y :Int, type :HitType)
    {
        var minX = box.x.m_value;
        var maxX = box.width.m_value + minX;
        var minY = box.y.m_value;
        var maxY = box.height.m_value + minY;
        if(
            minX <= x && maxX >= x &&
            minY <= y && maxY >= y
        ) {
            switch type {
                case DOWN: box.onDown(x,y);
                case UP: box.onUp(x,y);
                case MOVE: box.onMove(x,y);
            }
            var p = box.firstChild;
            while (p != null) {
                var next = p.nextSibling;
                hitTest_impl(p, x, y, type);
                p = next;
            }
        }
    }

    private var _model :Model;
    private var _updateFn :Msg -> Model -> Void;
    private var _viewFn :Model -> VElement;

    private var _oldView :VElement;
    private var _root :Element;
}

@:enum
abstract HitType(Int)
{
    var DOWN = 0;
    var UP = 1;
    var MOVE = 2;
}