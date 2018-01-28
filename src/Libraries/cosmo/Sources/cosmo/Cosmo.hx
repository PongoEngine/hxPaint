package cosmo;

import cosmo.element.*;
import cosmo.style.Style;
import cosmo.util.Signal2;
import jasper.Solver;
import jasper.Strength;

class Cosmo
{
    public var root (default, null) :Element;
    public static var solver (default, null) = new Solver();
    public static var pointerDown (default, null) = new Signal2<Int, Int>();
    public static var pointerUp (default, null) = new Signal2<Int, Int>();
    public static var pointerMove (default, null) = new Signal2<Int, Int>();

    public function new() : Void
    {
        var mainStyle = new Style();
        mainStyle.color = 0xffeeeeee;
        this.root = new Element(mainStyle, ELEMENT);

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

    public static function createElement(style :Style, elementType :ElementType) : Element
    {
        return switch elementType {
            case ELEMENT: new Element(style, ELEMENT);
            case CONTAINER: new Container(style);
            case BUTTON: new Button(style);
            case VERTICAL_DIVIDER: new VerticalDivider(style);
        }
    }

    private function initMouse() : Void
    {
        kha.input.Mouse.get().notify(function(button,x,y) {
            pointerDown.emit(x,y);
        }, function(button,x,y) {
            pointerUp.emit(x,y);
        }, function(x, y, cX, cY) {
            pointerMove.emit(x,y);
        }, function(w) {

        });
    }

    public static inline function isHit(box :Element, x :Int, y :Int) : Bool
    {
        var minX = box.x.m_value;
        var maxX = box.width.m_value + minX;
        var minY = box.y.m_value;
        var maxY = box.height.m_value + minY;
        
        return
            minX <= x && maxX >= x &&
            minY <= y && maxY >= y;
    }

    private static function render_impl(box :Element, framebuffer :kha.Framebuffer)
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