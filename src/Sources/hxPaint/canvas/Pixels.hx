package hxPaint.canvas;

abstract Pixels(Array<Int>)
{
    public inline function new() : Void
    {
        this = [for (i in 0...16*16) 0];
    }

    public function getColor(xCell :Int, yCell :Int) : Int
    {
        var index = yCell * 16 + xCell;
        return this[index];
    }

    public function setColor(xCell :Int, yCell :Int, color :Int) : Void
    {
        if(xCell >= 16 || yCell >= 16 || xCell < 0 || yCell < 0) {
            return;
        }
        var index = (yCell * 16) + xCell;
        this[index] = color;
    }

    public function clear() : Void
    {
        for(i in 0...16*16) {
            this[i] = 0;
        }
    }

    public function isLeftWall(x :Int) : Bool
    {
        return x == 0;
    }

    public function isRightWall(x :Int) : Bool
    {
        return x == 15;
    }

    public function isTopWall(y :Int) : Bool
    {
        return y == 0;
    }

    public function isBottomWall(y :Int) : Bool
    {
        return y == 15;
    }

    public function fill(x :Int, y :Int, targetColor :Int, replacementColor :Int) : Void
    {
        if(targetColor == replacementColor) return;
        if(getColor(x,y) != targetColor) return;
        setColor(x,y,replacementColor);

        if(!isBottomWall(y)) {
            fill(x, y+1, targetColor, replacementColor);
        }
        if(!isTopWall(y)) {
            fill(x, y-1, targetColor, replacementColor);
        }
        if(!isLeftWall(x)) {
            fill(x-1, y, targetColor, replacementColor);
        }
        if(!isRightWall(x)) {
            fill(x+1, y, targetColor, replacementColor);
        }
        
        return;
    }

    public function drawEllipse(x0 :Int, y0 :Int, x1 :Int, y1 :Int) : Void
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
            setColor(x1, y0, 0xff00ff00); /*   I. Quadrant */
            setColor(x0, y0, 0xff00ff00); /*  II. Quadrant */
            setColor(x0, y1, 0xff00ff00); /* III. Quadrant */
            setColor(x1, y1, 0xff00ff00); /*  IV. Quadrant */
            e2 = 2*err;
            if (e2 <= dy) { y0++; y1--; err += dy += a; }  /* y step */ 
            if (e2 >= dx || 2*err > dy) { x0++; x1--; err += dx += b1; } /* x step */
        } while (x0 <= x1);
        
        while (y0-y1 < b) {  /* too early stop of flat ellipses a=1 */
            setColor(x0-1, y0, 0xff00ff00); /* -> finish tip of ellipse */
            setColor(x1+1, y0++, 0xff00ff00); 
            setColor(x0-1, y1, 0xff00ff00);
            setColor(x1+1, y1--, 0xff00ff00); 
        }
    }

    public function plotLine(x0 :Int, y0 :Int, x1 :Int, y1 :Int) : Void
    {
        if (Math.abs(y1 - y0) < Math.abs(x1 - x0)) {
            if (x0 > x1) {
                plotLineLow(x1, y1, x0, y0);
            }
            else {
                plotLineLow(x0, y0, x1, y1);
            }
        }
        else {
            if (y0 > y1) {
                plotLineHigh(x1, y1, x0, y0);
            }
            else {
                plotLineHigh(x0, y0, x1, y1);
            }
        }
            
    }

    private function plotLineLow(x0 :Int, y0 :Int, x1 :Int, y1 :Int) : Void
    {
        var dx = x1 - x0;
        var dy = y1 - y0;
        var yi = 1;
        if (dy < 0) {
            yi = -1;
            dy = -dy;
        }
        var D = 2*dy - dx;
        var y = y0;

        for(x in x0...x1+1) {
            setColor(x, y, 0xff00ff00);
            if (D > 0) {
                y = y + yi;
                D = D - 2*dx;
            }
            D = D + 2*dy;
        }
    }

    private function plotLineHigh(x0 :Int, y0 :Int, x1 :Int, y1 :Int) : Void
    {
        var dx = x1 - x0;
        var dy = y1 - y0;
        var xi = 1;
        if (dx < 0) {
            xi = -1;
            dx = -dx;
        }
        var D = 2*dx - dy;
        var x = x0;

        for(y in y0...y1+1) {
            setColor(x, y, 0xff00ff00);
            if(D > 0) {
                x = x + xi;
                D = D - 2*dy;
            }
            D = D + 2*dx;
        }
    }  
}