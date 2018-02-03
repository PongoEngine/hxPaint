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
                framebuffer.g2.color = _pixels.getColor(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                var color = _tempPixels.getColor(xCell,yCell);
                if(color != 0) {
                    framebuffer.g2.color = color;
                    framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);
                }

                framebuffer.g2.color = 0xff484848;
                framebuffer.g2.drawRect(xPos,yPos,_cellSquare, _cellSquare);
            }
        }
    }

    public function pencil(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        getCells(xOffset, yOffset, x, y, function(xCell,yCell) {
            _pixels.setColor(xCell, yCell, 0xffff0000);
        });
    }

    public function fill(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        getCells(xOffset, yOffset, x, y, function(xCell,yCell) {
            // _pixels.setColor(xCell, yCell, 0xffff0000);
            var cellColor = _pixels.getColor(xCell, yCell);
            _pixels.fill(xCell,yCell, cellColor, 0xff330055);
        });
    }

    public function erase(xOffset :Float, yOffset :Float, x :Int, y :Int) : Void
    {
        getCells(xOffset, yOffset, x, y, function(xCell,yCell) {
            _pixels.setColor(xCell, yCell, 0xffffffff);
        });
    }

    public function drawLine(xOffset :Float, yOffset :Float, x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        getCells(xOffset, yOffset, x0, y0, function(xCell0 :Int,yCell0 :Int) {
            getCells(xOffset, yOffset, x1, y1, function(xCell1 :Int,yCell1 :Int) {
                _tempPixels.clear();
                if(isTemp) {
                    _tempPixels.plotLine(xCell0, yCell0, xCell1, yCell1);
                }
                else {
                    _pixels.plotLine(xCell0, yCell0, xCell1, yCell1);
                }
            });
        });
    }

    public function drawEllipse(xOffset :Float, yOffset :Float, x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        getCells(xOffset, yOffset, x0, y0, function(xCell0 :Int,yCell0 :Int) {
            getCells(xOffset, yOffset, x1, y1, function(xCell1 :Int,yCell1 :Int) {
                _tempPixels.clear();
                if(isTemp) {
                    _tempPixels.drawEllipse(xCell0, yCell0, xCell1, yCell1);
                }
                else {
                    _pixels.drawEllipse(xCell0, yCell0, xCell1, yCell1);
                }
            });
        });
    }

    public function resize(width :Float, height :Float) : Void
    {
        var square = (width > height) ? height : width;

        _cellSquare = square/X_CELLS;
        _centerX = (width - _cellSquare*X_CELLS) / 2;
        _centerY = (height - _cellSquare*Y_CELLS) / 2;
    }

    private function getCells(xOffset :Float, yOffset :Float, x :Float, y :Float, fn :Int -> Int -> Void) : Void
    {
        var realX = x-(_centerX+xOffset);
        var realY = y-(_centerY+yOffset);
        var maxPos = _cellSquare*16;
        if(realX > maxPos || realY > maxPos || realX < 0 || realY < 0) {
            return;
        }
        return fn(Math.floor(realX / _cellSquare), Math.floor(realY / _cellSquare));
    }
      

    private var _cellSquare :Float;
    private var _centerX :Float;
    private var _centerY :Float;
    private var _pixels :Pixels;
    private var _tempPixels :Pixels;

    private static inline var X_CELLS = 16;
    private static inline var Y_CELLS = 16;
}