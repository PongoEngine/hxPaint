package perdita.element;

import perdita.Style;

class FillBox extends Box
{
    public var color :Int;

    public function new(color :Int, style :Style) : Void{
        this.color = color;
        super(style);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = color;
        framebuffer.g2.fillRect(_x.m_value, _y.m_value, _width.m_value, _height.m_value);
    }
}