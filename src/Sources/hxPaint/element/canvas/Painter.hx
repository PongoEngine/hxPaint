/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package hxPaint.element.canvas;

import hxPaint.element.canvas.Pixels;

using Math;

class Painter
{
    public function new() : Void
    {
        _cellSquare = 0;
        _centerX = 0;
        _centerY = 0;
        _pixels = new Pixels();
        _tempPixels = new Pixels();
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
        for(xCell in 0...X_CELLS) {
            for(yCell in 0...Y_CELLS) {
                var xPos = _centerX + xCell*_cellSquare;
                var yPos = _centerY + yCell*_cellSquare;
                
                framebuffer.g2.color = _pixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                framebuffer.g2.color = _tempPixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                framebuffer.g2.color = 0xff484848;
                framebuffer.g2.drawRect(xPos,yPos,_cellSquare, _cellSquare);
            }
        }
    }

    public function pencil(x :Int, y :Int) : Void
    {
        var xCell = xCell(x);
        var yCell = yCell(y);

        _pixels.setPixel(xCell, yCell, 0xffff0000);
    }

    public function fill(x :Int, y :Int) : Void
    {
        var xCell = xCell(x);
        var yCell = yCell(y);

        var cellColor = _pixels.getPixel(xCell, yCell);
        _pixels.fill(xCell,yCell, cellColor, 0xff330055);
    }

    public function erase(x :Int, y :Int) : Void
    {
        var xCell = xCell(x);
        var yCell = yCell(y);

        _pixels.setPixel(xCell, yCell, 0);
    }

    public function drawLine(x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(x0);
        var yCell0 = yCell(y0);
        var xCell1 = xCell(x1);
        var yCell1 = yCell(y1);

        _tempPixels.clear();
        if(isTemp) {
            _tempPixels.drawLine(xCell0, yCell0, xCell1, yCell1, 0xff00ff0f);
        }
        else {
            _pixels.drawLine(xCell0, yCell0, xCell1, yCell1, 0xff00ff0f);
        }
    }

    public function drawEllipse(x0 :Int, y0 :Int, x1 :Int, y1 :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(x0);
        var yCell0 = yCell(y0);
        var xCell1 = xCell(x1);
        var yCell1 = yCell(y1);

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

    private inline function xCell(x :Float) : Int
    {
        return Math.floor((x-_centerX) / _cellSquare);
    }

    private inline function yCell(y :Float) : Int
    {
        return Math.floor((y-_centerY) / _cellSquare);
    }

    private var _cellSquare :Float;
    private var _centerX :Float;
    private var _centerY :Float;
    private var _pixels :Pixels;
    private var _tempPixels :Pixels;

    private static inline var X_CELLS = 16;
    private static inline var Y_CELLS = 16;
}