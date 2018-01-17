package hxPaint.app;

typedef Model =
{
    var pencil: DrawOption;
    var fill: DrawOption;
    var eraser :Eraser;
    var colors :Array<Int>;
    var pixels :Array<Int>;
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