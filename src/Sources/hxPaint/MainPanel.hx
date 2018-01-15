package hxPaint;

class MainPanel extends Box
{
    public var color :Int;

    public function new(color :Int) : Void
    {
        super();
        this.color = color;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == 120);
        solver.addConstraint(this.y == parent.y + 10);
        solver.addConstraint(this.width == parent.width - 240);
        solver.addConstraint(this.height == parent.height - 20);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}