package wanda.virtual;

import cosmo.style.Style;

class VElement
{
    public var nodeType (default, null):VNodeType;
    public var style (default, null):Style;
    public var children :Array<VElement>;

    public function new(nodeType :VNodeType, style :Style, children :Array<VElement>) : Void
    {
        this.nodeType = nodeType;
        this.style = style;
        this.children = children;
    }
}