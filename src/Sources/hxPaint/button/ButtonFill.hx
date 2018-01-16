package hxPaint.button;

import jasper.Solver;

class ButtonFill extends Button
{
    public var solver :Solver;

    public function new(solver :Solver, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        solver.addConstraint(this.y == prev.y + prev.height + 40);
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff444444;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff000000;
    }
}