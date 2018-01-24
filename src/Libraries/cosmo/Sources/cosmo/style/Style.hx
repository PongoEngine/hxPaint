package cosmo.style;

class Style
{
    public var x :Value;
    public var y :Value;
    public var width :Value;
    public var height :Value;
    public var direction :Direction;
    public var align :Align;
    public var color :Int;

    public function new() : Void
    {
        this.x = INHERIT;
        this.y = INHERIT;
        this.width = INHERIT;
        this.height = INHERIT;
        this.direction = HORIZONTAL;
        this.align = LEFT;
        this.color = 0;
    }
}