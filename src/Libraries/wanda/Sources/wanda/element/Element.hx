package wanda.element;

import cosmo.style.Style;
import wanda.virtual.VElement;

class Element
{
    public static function element(style :Style, children :Array<VElement>) : VElement
    {
        return new VElement(ELEMENT, style, children);
    }

    public static function container(style :Style, children :Array<VElement>) : VElement
    {
        return new VElement(CONTAINER, style, children);
    }

    public static function button(style :Style, children :Array<VElement>) : VElement
    {
        return new VElement(BUTTON, style, children);
    }
}