package cosmo.style;

class Style
{
    public var x :Value;
    public var y :Value;

    public var width :Value;
    public var minWidth :Value;
    public var maxWidth :Value;

    public var height :Value;
    public var minHeight :Value;
    public var maxHeight :Value;

    public var direction :Direction;
    public var color :Int;

    public function new() : Void
    {
        this.x = INHERIT;
        this.y = INHERIT;

        this.width = INHERIT;
        this.minWidth = INHERIT;
        this.maxWidth = INHERIT;

        this.height = INHERIT;
        this.minHeight = INHERIT;
        this.maxHeight = INHERIT;

        this.direction = HORIZONTAL;
        this.color = 0;
    }
}