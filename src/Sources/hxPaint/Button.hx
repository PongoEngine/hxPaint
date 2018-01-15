package hxPaint;

import jasper.Solver;

class Button extends Box
{
    public var color :Int;

    public function new(solver :Solver, color :Int) : Void
    {
        super(solver);
        this.color = color;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        
        if(prev == null) {
            solver.addConstraint(this.y == parent.y + 5);
        }
        else {
            solver.addConstraint(this.y == prev.y + prev.height + 5);
        }
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}