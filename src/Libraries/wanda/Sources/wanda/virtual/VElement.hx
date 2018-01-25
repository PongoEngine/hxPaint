package wanda.virtual;

import cosmo.style.Style;
import cosmo.element.ElementType;

class VElement
{
    public var elementType (default, null):ElementType;
    public var style (default, null):Style;
    public var children :Array<VElement>;

    public function new(elementType :ElementType, style :Style, children :Array<VElement>) : Void
    {
        this.elementType = elementType;
        this.style = style;
        this.children = children;
    }
}