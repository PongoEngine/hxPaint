package cosmo.style;

class Style
{
    public var x :Value;
    public var y :Value;

    public var width :Value;
    public var height :Value;

    public var align :Alignment;
    public var direction :Direction;
    public var color :Int;

    public function new() : Void
    {
        this.x = INHERIT;
        this.y = INHERIT;
        this.width = INHERIT;
        this.height = INHERIT;
        this.align = LEFT_ALIGN;

        this.direction = HORIZONTAL;
        this.color = 0;
    }
}