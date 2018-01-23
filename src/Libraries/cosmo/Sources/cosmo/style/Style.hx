package cosmo.style;

class Style
{
    public var x :Constraint;
    public var y :Constraint;
    public var width :Constraint;
    public var height :Constraint;
    public var color :Int;

    public function new() : Void
    {
        this.x = INHERIT;
        this.y = INHERIT;
        this.width = INHERIT;
        this.height = INHERIT;
        this.color = 0;
    }
}