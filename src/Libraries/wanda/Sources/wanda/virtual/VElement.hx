package wanda.virtual;

import cosmo.style.Style;
import cosmo.element.ElementType;

class VElement
{
    public var nodeType (default, null):ElementType;
    public var style (default, null):Style;
    public var children :Array<VElement>;

    public function new(nodeType :ElementType, style :Style, children :Array<VElement>) : Void
    {
        this.nodeType = nodeType;
        this.style = style;
        this.children = children;
    }
}