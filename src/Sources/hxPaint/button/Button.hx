package hxPaint.button;

class Button extends Box
{
    public function new(onClick : Void -> Void) : Void
    {
        super();
        _onClick = onClick;
    }

    override public function onDown(x :Int,y :Int) : Void
    {
        _onClick();
    }

    private var _onClick : Void -> Void;
}