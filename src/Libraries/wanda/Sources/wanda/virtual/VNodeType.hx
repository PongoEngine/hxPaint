package wanda.virtual;

@:enum
abstract VNodeType(String)
{
    var ELEMENT = "element";
    var CONTAINER = "container";
    var BUTTON = "button";
    var HORIZONTAL_DIVIDER = "horizontalDivider";
}