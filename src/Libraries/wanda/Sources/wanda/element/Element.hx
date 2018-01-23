package wanda.element;

import wanda.virtual.VElement;

class Element
{
    public static function element(children :Array<VElement>) : VElement
    {
        return new VElement(ELEMENT, children);
    }

    public static function container(children :Array<VElement>) : VElement
    {
        return new VElement(CONTAINER, children);
    }

    public static function button(children :Array<VElement>) : VElement
    {
        return new VElement(BUTTON, children);
    }
}