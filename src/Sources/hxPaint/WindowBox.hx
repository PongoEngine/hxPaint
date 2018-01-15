package hxPaint;

import jasper.Solver;
import jasper.Strength;

class WindowBox extends Box
{
    public var color :Int;

    public function new(color :Int, width :Int, height :Int, solver :Solver) : Void
    {
        super();
        this.color = color;
        this.solver = solver;
        init(width, height);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }

    private inline function init(width :Int, height :Int) : Void
    {
        this.solver.addConstraint(this.x == 0);
        this.solver.addConstraint(this.y == 0);
        this.solver.addConstraint((this.width == width) | Strength.WEAK);
        this.solver.addConstraint((this.height == height) | Strength.WEAK);

        this.solver.addConstraint((this.width <= width) | Strength.REQUIRED);
        this.solver.addConstraint((this.height <= height) | Strength.REQUIRED);
        this.solver.addConstraint((this.width >= 400) | Strength.REQUIRED);
        this.solver.addConstraint((this.height >= 300) | Strength.REQUIRED);

        this.solver.addEditVariable(this.width, Strength.MEDIUM);
        this.solver.addEditVariable(this.height, Strength.MEDIUM);
        this.solver.suggestValue(this.width, width);
        this.solver.suggestValue(this.height, height);
    }
}