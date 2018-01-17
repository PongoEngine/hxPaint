package hxPaint.ui.button;

class Button extends Box
{
    public var isOn :Bool;

    public function new(onClick : Void -> Void) : Void
    {
        super();
        isOn = false;
        _onClick = onClick;
    }

    override public function onDown(x :Int,y :Int) : Void
    {
        _onClick();
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff444444;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);

        if(isOn) {
            framebuffer.g2.color = 0xffffffff;
            framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value, 3);
        }
    }

    public function setOn(isOn :Bool) : Button
    {
        this.isOn = isOn;
        return this;
    }

    private var _onClick : Void -> Void;
}