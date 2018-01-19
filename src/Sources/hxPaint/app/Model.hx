package hxPaint.app;

import hxPaint.ui.Operation;
import hxPaint.ui.Pixels;

typedef Model =
{
    var color :Int;
    var operation :Operation;
    var pencil :DrawOption;
    var fill :DrawOption;
    var eraser :Eraser;
    var colors :Array<Int>;
    var pixels :Pixels;
    var rowLength :Int;
}

typedef DrawOption =
{
    var isOn :Bool;
    var color1 :Int;
    var color2 :Int;
    var color3 :Int;
}

typedef Eraser =
{
    var isOn :Bool;
}