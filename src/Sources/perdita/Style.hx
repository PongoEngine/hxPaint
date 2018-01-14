package perdita;

class Style
{
    // public var paddingTop :ValueConstraint;
    // public var paddingRight :ValueConstraint;
    // public var paddingBottom :ValueConstraint;
    // public var paddingLeft :ValueConstraint;

    // public var marginTop :ValueConstraint;
    // public var marginRight :ValueConstraint;
    // public var marginBottom :ValueConstraint;
    // public var marginLeft :ValueConstraint;

    public var width :ValueConstraint;
    public var height :ValueConstraint;

    public var direction :Direction;

    public function new() : Void
    {
        // paddingTop = INHERIT;
        // paddingRight = INHERIT;
        // paddingBottom = INHERIT;
        // paddingLeft = INHERIT;

        // marginTop = INHERIT;
        // marginRight = INHERIT;
        // marginBottom = INHERIT;
        // marginLeft = INHERIT;

        width = INHERIT;
        height = INHERIT;
        
        direction = VERTICAL;
    }

    public function updateStyle(fn :Style -> Void) : Style
    {
        fn(this);
        return this;
    }
}