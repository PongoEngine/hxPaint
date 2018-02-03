package hxPaint.canvas;

import hxPaint.canvas.Pixels;

using Math;

class Canvas
{
    public function new() : Void
    {
        _cellSquare = 0;
        _centerX = 0;
        _centerY = 0;
        _pixels = new Pixels();
        _tempPixels = new Pixels();
    }

    public function draw(xOffset :Float, yOffset :Float, framebuffer :kha.Framebuffer) : Void
    {
        for(xCell in 0...X_CELLS) {
            for(yCell in 0...Y_CELLS) {
                var xPos = _centerX + xOffset + xCell*_cellSquare;
                var yPos = _centerY + yOffset + yCell*_cellSquare;
                
                framebuffer.g2.color = _pixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                framebuffer.g2.color = _tempPixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                framebuffer.g2.color = 0xff484848;
                framebuffer.g2.drawRect(xPos,yPos,_cellSquare, _cellSquare);
            }
        }
    }

    public function pencil(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        var xCell = xCell(xOffset, x);
        var yCell = yCell(yOffset, y);

        _pixels.setPixel(xCell, yCell, 0xffff0000);
    }

    public function fill(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        var xCell = xCell(xOffset, x);
        var yCell = yCell(yOffset, y);

        var cellColor = _pixels.getPixel(xCell, yCell);
        _pixels.fill(xCell,yCell, cellColor, 0xff330055);
    }

    public function erase(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        var xCell = xCell(xOffset, x);
        var yCell = yCell(yOffset, y);

        _pixels.setPixel(xCell, yCell, 0);
    }

    public function drawLine(xOffset :Float, yOffset :Float, x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(xOffset, x0);
        var yCell0 = yCell(yOffset, y0);
        var xCell1 = xCell(xOffset, x1);
        var yCell1 = yCell(yOffset, y1);

        _tempPixels.clear();
        if(isTemp) {
            _tempPixels.drawLine(xCell0, yCell0, xCell1, yCell1, 0xff00ff0f);
        }
        else {
            _pixels.drawLine(xCell0, yCell0, xCell1, yCell1, 0xff00ff0f);
        }
    }

    public function drawEllipse(xOffset :Float, yOffset :Float, x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(xOffset, x0);
        var yCell0 = yCell(yOffset, y0);
        var xCell1 = xCell(xOffset, x1);
        var yCell1 = yCell(yOffset, y1);

        _tempPixels.clear();
        if(isTemp) {
            _tempPixels.drawEllipse(xCell0, yCell0, xCell1, yCell1, 0xff00f0f0);
        }
        else {
            _pixels.drawEllipse(xCell0, yCell0, xCell1, yCell1, 0xff00f0f0);
        }
    }

    public function resize(width :Float, height :Float) : Void
    {
        var square = (width > height) ? height : width;

        _cellSquare = square/X_CELLS;
        _centerX = (width - _cellSquare*X_CELLS) / 2;
        _centerY = (height - _cellSquare*Y_CELLS) / 2;
    }

    private inline function xCell(xOffset :Float, x :Float) : Int
    {
        var realX = x-(_centerX+xOffset);
        return Math.floor(realX / _cellSquare);
    }

    private inline function yCell(yOffset :Float, y :Float) : Int
    {
        var realY = y-(_centerY+yOffset);
        return Math.floor(realY / _cellSquare);
    }

    private var _cellSquare :Float;
    private var _centerX :Float;
    private var _centerY :Float;
    private var _pixels :Pixels;
    private var _tempPixels :Pixels;

    private static inline var X_CELLS = 16;
    private static inline var Y_CELLS = 16;
}