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

import kha.Color;

abstract Pixels(Array<Int>)
{
    public static inline var SIZE :Int = 64;

    public inline function new() : Void
    {
        this = [for (i in 0...SIZE*SIZE) YELLOW_GREEN];
    }

    /**
     *  [Description]
     *  @param xCell - 
     *  @param yCell - 
     *  @return Int
     */
    public function getPixel(xCell :Int, yCell :Int) : Int
    {
        var index = yCell * SIZE + xCell;
        return this[index];
    }

    /**
     *  [Description]
     *  @param xCell - 
     *  @param yCell - 
     *  @param color - 
     */
    public function setPixel(xCell :Int, yCell :Int, color :Int) : Void
    {
        if(xCell >= SIZE || yCell >= SIZE || xCell < 0 || yCell < 0) {
            return;
        }
        var index = (yCell * SIZE) + xCell;
        this[index] = color;
    }

    /**
     *  [Description]
     *  @param color - 
     */
    public function clear(color :Int = 0) : Void
    {
        for(i in 0...SIZE*SIZE) {
            this[i] = color;
        }
    }

    /**
     *  [Description]
     *  @param xCell - 
     *  @param yCell - 
     *  @param targetColor - 
     *  @param replacementColor - 
     */
    public function fill(xCell :Int, yCell :Int, targetColor :Int, replacementColor :Int) : Void
    {
        if(targetColor == replacementColor) return;
        if(getPixel(xCell,yCell) != targetColor) return;
        setPixel(xCell,yCell,replacementColor);

        if(yCell < SIZE-1) {
            fill(xCell, yCell+1, targetColor, replacementColor);
        }
        if(yCell > 0) {
            fill(xCell, yCell-1, targetColor, replacementColor);
        }
        if(xCell > 0) {
            fill(xCell-1, yCell, targetColor, replacementColor);
        }
        if(xCell < SIZE-1) {
            fill(xCell+1, yCell, targetColor, replacementColor);
        }
    }

    /**
     *  [Description]
     *  @param x0 - 
     *  @param y0 - 
     *  @param x1 - 
     *  @param y1 - 
     *  @param color - 
     */
    public function drawEllipse(x0 :Int, y0 :Int, x1 :Int, y1 :Int, color :Int) : Void
    {
        var a :Int = Std.int(Math.abs(x1-x0));
        var b :Int = Std.int(Math.abs(y1-y0));
        var b1 = b&1; /* values of diameter */
        var dx :Int = 4*(1-a)*b*b;
        var dy :Int = 4*(b1+1)*a*a; /* error increment */
        var err :Int = dx+dy+b1*a*a;
        var e2 :Int; /* error of 1.step */

        if (x0 > x1) { 
            x0 = x1; x1 += a; /* if called with swapped points */
        } 
        if (y0 > y1) {
            y0 = y1; /* .. exchange them */
        }
        y0 += Std.int((b+1)/2); 
        y1 = y0-b1;   /* starting pixel */
        a *= 8*a; 
        b1 = 8*b*b;

        do {
            setPixel(x1, y0, color); /*   I. Quadrant */
            setPixel(x0, y0, color); /*  II. Quadrant */
            setPixel(x0, y1, color); /* III. Quadrant */
            setPixel(x1, y1, color); /*  IV. Quadrant */
            e2 = 2*err;
            if (e2 <= dy) { y0++; y1--; err += dy += a; }  /* y step */ 
            if (e2 >= dx || 2*err > dy) { x0++; x1--; err += dx += b1; } /* x step */
        } while (x0 <= x1);
        
        while (y0-y1 < b) {  /* too early stop of flat ellipses a=1 */
            setPixel(x0-1, y0, color); /* -> finish tip of ellipse */
            setPixel(x1+1, y0++, color); 
            setPixel(x0-1, y1, color);
            setPixel(x1+1, y1--, color); 
        }
    }

    /**
     *  [Description]
     *  @param x0 - 
     *  @param y0 - 
     *  @param x1 - 
     *  @param y1 - 
     *  @param color - 
     */
    public function drawLine(x0 :Int, y0 :Int, x1 :Int, y1 :Int, color :Int) : Void
    {
        var dx :Int =  Std.int(Math.abs(x1-x0));
        var sx :Int = x0<x1 ? 1 : -1;
        var dy :Int = Std.int(-Math.abs(y1-y0));
        var sy :Int = y0<y1 ? 1 : -1; 
        var err :Int = dx+dy;
        var e2 :Int; /* error value e_xy */
        
        while(true){  /* loop */
            setPixel(x0, y0, color);
            if (x0==x1 && y0==y1) {
                break;
            }
            e2 = 2*err;
            if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
            if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
        }
    } 

    public static inline var BLACK :Color = 0xff000000;
    public static inline var BLUE :Color = 0xff0066FF;
    public static inline var BROWN :Color = 0xffAF593E;
    public static inline var GREEN :Color = 0xff01A368;
    public static inline var ORANGE :Color = 0xffFF861F;
    public static inline var RED :Color = 0xffED0A3F;
    public static inline var RED_ORANGE :Color = 0xffFF3F34;
    public static inline var SKY_BLUE :Color = 0xff76D7EA;
    public static inline var VIOLET :Color = 0xff8359A3;
    public static inline var WHITE :Color = 0xffFFFFFF;
    public static inline var YELLOW :Color = 0xffFBE870;
    public static inline var YELLOW_GREEN :Color = 0xffC5E17A;
    private static var colors :Array<Color> = [ BLACK, BLUE, BROWN, GREEN, ORANGE, RED, RED_ORANGE, SKY_BLUE, VIOLET, WHITE, YELLOW, YELLOW_GREEN];
}