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

    public var showEdges :Bool;

    public function new() : Void
    {
        _cellSquare = 0;
        _centerX = 0;
        _centerY = 0;
        _pixels = new Pixels();
        _tempPixels = new Pixels();

        _lastPencilX = 0;
        _lastPencilY = 0;

        showEdges = false;
    }

    /**
     *  [Description]
     *  @param framebuffer - 
     */
    public function draw(framebuffer :kha.Framebuffer) : Void
    {
        for(xCell in 0...Pixels.SIZE) {
            for(yCell in 0...Pixels.SIZE) {
                var xPos = _centerX + xCell*_cellSquare;
                var yPos = _centerY + yCell*_cellSquare;
                
                framebuffer.g2.color = _pixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                framebuffer.g2.color = _tempPixels.getPixel(xCell,yCell);
                framebuffer.g2.fillRect(xPos,yPos,_cellSquare, _cellSquare);

                if(showEdges) {
                    framebuffer.g2.color = 0xff484848;
                    framebuffer.g2.drawRect(xPos,yPos,_cellSquare, _cellSquare);
                }
            }
        }

        framebuffer.g2.color = 0xff484848;
        framebuffer.g2.drawRect(_centerX, _centerY, _cellSquare*Pixels.SIZE - 1, _cellSquare*Pixels.SIZE - 1);
    }

    /**
     *  [Description]
     *  @param x - 
     *  @param y - 
     *  @param color - 
     *  @param isFresh - 
     */
    public function pencil(x :Int, y :Int, color :Int, isFresh :Bool) : Void
    {
        if(isFresh) {
            var xCell = xCell(x);
            var yCell = yCell(y);
            _pixels.setPixel(xCell, yCell, color);
        }
        else {
            drawLine(x, y, _lastPencilX, _lastPencilY, color, false);
        }
        
        _lastPencilX = x;
        _lastPencilY = y;
    }

    /**
     *  [Description]
     *  @param x - 
     *  @param y - 
     *  @param color - 
     */
    public function fill(x :Int, y :Int, color :Int) : Void
    {
        var xCell = xCell(x);
        var yCell = yCell(y);

        var cellColor = _pixels.getPixel(xCell, yCell);
        _pixels.fill(xCell,yCell, cellColor, color);
    }

    /**
     *  [Description]
     *  @param x - 
     *  @param y - 
     */
    public function erase(x :Int, y :Int) : Void
    {
        var xCell = xCell(x);
        var yCell = yCell(y);

        for(eX in -2...3) {
            for(eY in -2...3) {
                _pixels.setPixel(xCell + eX, yCell + eY, 0);
            }
        }
    }

    /**
     *  [Description]
     *  @param x0 - 
     *  @param y0 - 
     *  @param x1 - 
     *  @param y1 - 
     *  @param color - 
     *  @param isTemp - 
     */
    public function drawLine(x0 :Int, y0 :Int, x1 :Int, y1 :Int, color :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(x0);
        var yCell0 = yCell(y0);
        var xCell1 = xCell(x1);
        var yCell1 = yCell(y1);

        _tempPixels.clear();
        if(isTemp) {
            _tempPixels.drawLine(xCell0, yCell0, xCell1, yCell1, color);
        }
        else {
            _pixels.drawLine(xCell0, yCell0, xCell1, yCell1, color);
        }
    }

    /**
     *  [Description]
     *  @param x0 - 
     *  @param y0 - 
     *  @param x1 - 
     *  @param y1 - 
     *  @param color - 
     *  @param isTemp - 
     */
    public function drawEllipse(x0 :Int, y0 :Int, x1 :Int, y1 :Int, color :Int, isTemp :Bool) : Void
    {
        var xCell0 = xCell(x0);
        var yCell0 = yCell(y0);
        var xCell1 = xCell(x1);
        var yCell1 = yCell(y1);

        _tempPixels.clear();
        if(isTemp) {
            _tempPixels.drawEllipse(xCell0, yCell0, xCell1, yCell1, color);
        }
        else {
            _pixels.drawEllipse(xCell0, yCell0, xCell1, yCell1, color);
        }
    }

    /**
     *  [Description]
     *  @param width - 
     *  @param height - 
     */
    public function resize(width :Float, height :Float) : Void
    {
        var square = (width > height) ? height : width;

        _cellSquare = square/Pixels.SIZE;
        _centerX = (width - _cellSquare*Pixels.SIZE) / 2;
        _centerY = (height - _cellSquare*Pixels.SIZE) / 2;
    }

    /**
     *  [Description]
     *  @param x - 
     *  @return Int
     */
    private inline function xCell(x :Float) : Int
    {
        return Math.floor((x-_centerX) / _cellSquare);
    }

    /**
     *  [Description]
     *  @param y - 
     *  @return Int
     */
    private inline function yCell(y :Float) : Int
    {
        return Math.floor((y-_centerY) / _cellSquare);
    }

    private var _cellSquare :Float;
    private var _centerX :Float;
    private var _centerY :Float;
    private var _pixels :Pixels;
    private var _tempPixels :Pixels;

    private var _lastPencilX :Int;
    private var _lastPencilY :Int;
}