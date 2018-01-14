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

    public function new() : Void
    {
        // paddingTop = NONE;
        // paddingRight = NONE;
        // paddingBottom = NONE;
        // paddingLeft = NONE;

        // marginTop = NONE;
        // marginRight = NONE;
        // marginBottom = NONE;
        // marginLeft = NONE;

        width = NONE;
        height = NONE;
    }

    public function updateStyle(fn :Style -> Void) : Style
    {
        fn(this);
        return this;
    }
}