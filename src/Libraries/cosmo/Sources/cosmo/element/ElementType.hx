package cosmo.element;

@:enum
abstract ElementType(String)
{
    var ELEMENT = "element";
    var CONTAINER = "container";
    var BUTTON = "button";
    var VERTICAL_DIVIDER = "verticalDivider";
    var HORIZONTAL_DIVIDER = "horizontalDivider";
}