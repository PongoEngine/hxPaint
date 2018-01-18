package hxPaint.ui;

import jasper.Solver;
import hxPaint.app.Msg;

class Color extends Box
{
    public var color :Int;
    public var solver :Solver;

    public function new(solver :Solver, color :Int, onClick : Int -> Void) : Void
    {
        super();
        this.color = color;
        this.solver = solver;
        _onClick = onClick;
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        _onClick(this.color);
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        
        if(prev == null) {
            solver.addConstraint(this.y == parent.y + 5);
        }
        else {
            solver.addConstraint(this.y == prev.y + prev.height + 2);
        }
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == 30);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xdd000000;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value - 0.5, height.m_value - 0.5, 1);
    }

    private var _onClick :Int -> Void;
}