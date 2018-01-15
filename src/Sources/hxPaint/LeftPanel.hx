package hxPaint;

class LeftPanel extends Box
{
    public var color :Int;

    public function new(color :Int) : Void
    {
        super();
        this.color = color;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 10);
        solver.addConstraint(this.y == parent.y + 10);
        solver.addConstraint(this.width == 100);
        solver.addConstraint(this.height == parent.height - 20);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}