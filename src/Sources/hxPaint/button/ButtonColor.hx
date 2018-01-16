package hxPaint.button;

import jasper.Solver;

class ButtonColor extends Button
{
    public var solver :Solver;
    public var index :Int;

    public function new(solver :Solver, index :Int, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
        this.index = index;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + (this.index * (parent.width/3)) + 1);
        solver.addConstraint(this.y == parent.y + parent.height + 2);
        
        solver.addConstraint(this.width == parent.width/3 - 2);
        solver.addConstraint(this.height == parent.width/3);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff444444;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff000000;
    }
}