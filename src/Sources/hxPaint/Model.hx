package hxPaint;

import hxPaint.element.canvas.PaintOperation;
import hxPaint.element.canvas.Pixels;
import kha.Color;

class Model
{
    public var operation :PaintOperation;
    public var pencilColor :Color;
    public var fillColor :Color;
    public var lineColor :Color;
    public var circleColor :Color;

    public function new() : Void
    {
        this.operation = PENCIL;
        this.pencilColor = Pixels.BLACK;
        this.fillColor = Pixels.BLACK;
        this.lineColor = Pixels.BLACK;
        this.circleColor = Pixels.BLACK;
    }

    public function selectColor(color :Color) : Void
    {
        switch this.operation {
            case CIRCLE: this.circleColor = color;
            case FILL: this.fillColor = color;
            case LINE: this.lineColor = color;
            case PENCIL: this.pencilColor = color;
            case _:
        }
    } 
}