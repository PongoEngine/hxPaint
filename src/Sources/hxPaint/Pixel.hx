package hxPaint;

import jasper.Solver;

class Pixel extends Box
{
    public var index :Int;
    public var isColored :Bool;
    public var color :Int;

    public function new(solver :Solver, index :Int) : Void
    {
        super(solver);
        this.index = index;
        this.isColored = false;
    }

    override public function onDown(x:Int, y:Int) : Void
    {
        if(this.color != Main.color && isColored) {
            this.color = Main.color;
        }
        else if(isColored) {
            this.isColored = false;
        }
        else {
            this.isColored = true;
            this.color = Main.color;
        }
    }


    override public function onAdded() : Void
    {
        var x = index%8;
        var y = Math.floor(index/8);
        solver.addConstraint(this.x == parent.x + (x * 50) + 20);
        solver.addConstraint(this.y == parent.y + (y * 50) + 20);
        solver.addConstraint(this.width == 50);
        solver.addConstraint(this.height == 50);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        if(isColored) {
            framebuffer.g2.color = this.color;
            framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        }
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}