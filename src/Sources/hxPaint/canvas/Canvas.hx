package hxPaint.canvas;

class Canvas
{
    public function new() : Void
    {
        _cellSquare = 0;
        _centerX = 0;
        _centerY = 0;
    }

    public function draw(xOffset :Float, yOffset :Float, framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = 0xff484848;
        for(x in 0...X_CELLS) {
            for(y in 0...Y_CELLS) {
                var x = _centerX + xOffset + x*_cellSquare;
                var y = _centerY + yOffset + y*_cellSquare;
                framebuffer.g2.drawRect(x,y,_cellSquare, _cellSquare);
            }
        }
    }

    public function resize(width :Float, height :Float) : Void
    {
        var square = (width > height) ? height : width;

        _cellSquare = square/X_CELLS;
        _centerX = (width - _cellSquare*X_CELLS) / 2;
        _centerY = (height - _cellSquare*Y_CELLS) / 2;
    }

    private var _cellSquare :Float;
    private var _centerX :Float;
    private var _centerY :Float;

    private static inline var X_CELLS = 16;
    private static inline var Y_CELLS = 16;
}