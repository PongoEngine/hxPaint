package cosmo.element;

import cosmo.style.Style;

class Container extends Element
{
    public function new(style :Style) : Void
    {
        super(style, CONTAINER);
    }
}