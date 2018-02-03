package hxPaint;

@:enum
abstract PaintOperation(Int)
{
    var INVALID = -1;
    var PENCIL = 1;
    var FILL = 2;
    var LINE = 3;
    var CIRCLE = 4;
    var ERASER = 5;
}