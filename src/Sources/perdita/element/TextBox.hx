package perdita.element;

import perdita.Style;

class TextBox extends Box
{
    public var text :String;

    public function new(text :String, style :Style) : Void{
        this.text = text;
        super(style);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff000000;
        var width = framebuffer.g2.font.width(18, text);
        var length = Math.ceil(width/_width.m_value);
        var characters = Math.round(text.length/length);
        var x = _x.m_value;
        var y = _y.m_value;
        for(i in 0...length) {
            var start = i*characters;
            var end = start+characters;
            framebuffer.g2.drawString(text.substring(start,end), x, y);
            y += 18;
        }
    }
}