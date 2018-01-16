package hxPaint;

@:enum
abstract Operation(Int)
{
    var PENCIL = 0;
    var FILL = 1;
    var ERASER = 2;
}