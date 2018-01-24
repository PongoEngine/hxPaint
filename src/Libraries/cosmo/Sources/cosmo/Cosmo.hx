package cosmo;

import cosmo.element.Element;
import cosmo.style.Style;
import jasper.Solver;
import jasper.Strength;

class Cosmo
{
    public var root (default, null) :Element;
    public static var solver (default, null) = new Solver();

    public function new() : Void
    {
        var mainStyle = new Style();
        mainStyle.color = 0xff333333;
        this.root = new Element(mainStyle);

        Cosmo.solver.addConstraint(this.root.x == 0);
        Cosmo.solver.addConstraint(this.root.y == 0);
        Cosmo.solver.addConstraint((this.root.width == kha.System.windowWidth()) | Strength.WEAK);
        Cosmo.solver.addConstraint((this.root.height == kha.System.windowHeight()) | Strength.WEAK);

        initMouse();
    }

    public function render(framebuffer :kha.Framebuffer) : Void
    {
        render_impl(root, framebuffer);
    }

    private function initMouse() : Void
    {
        kha.input.Mouse.get().notify(function(button,x,y) {
            hitTest_impl(root, x, y, DOWN);
        }, function(button,x,y) {
            hitTest_impl(root, x, y, UP);
        }, function(x, y, cX, cY) {
            hitTest_impl(root, x, y, MOVE);
        }, function(w) {

        });
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
}

@:enum
abstract HitType(Int)
{
    var DOWN = 0;
    var UP = 1;
    var MOVE = 2;
}