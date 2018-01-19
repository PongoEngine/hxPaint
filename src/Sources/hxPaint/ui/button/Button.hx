package hxPaint.ui.button;

class Button extends Box
{
    public var isOn :Bool;
    public var color :Int = 0xff000000;
    public var shadow :Int = 0xff666666;

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
        framebuffer.g2.color = isOn ? color : shadow;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);

        if(!isOn) {
            framebuffer.g2.color = color;
            framebuffer.g2.fillRect(x.m_value, y.m_value + 3, width.m_value, height.m_value);
        }
    }

    public function setOn(isOn :Bool) : Button
    {
        this.isOn = isOn;
        return this;
    }

    private var _onClick : Void -> Void;
}