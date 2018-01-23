package cosmo.element;

class Button extends Element
{
    public function new() : Void
    {
        super();
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xffff33ff;
        framebuffer.g2.fillRect(this.x.m_value,this.y.m_value,this.width.m_value,this.height.m_value);
    }
}