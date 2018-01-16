package hxPaint;

@:enum
abstract Operation(Int)
{
    var PENCIL = 0;
    var FILL = 1;
    var ERASER = 2;

    public function toString() : String
    {
        return switch cast(this, Operation)
        {
            case PENCIL: "Pencil";
            case FILL: "Fill";
            case ERASER: "Eraser";
        }
    }
}