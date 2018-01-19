package hxPaint.ui;

abstract Pixels(Array<Int>)
{
    public inline function new(width :Int, height :Int) : Void
    {
        this = [for (i in 2...(width*height + 2)) 0xffffffff];
        this.push(width);
        this.push(height);
    }

    public inline function setColor(x :Int, y :Int, color :Int) : Void
    {
        var index = y * height() + x;
        this[index] = color;
    }

    public inline function getColor(x :Int, y :Int) : Int
    {
        var index = y * height() + x;
        return this[index];
    }

    public inline function width() : Int
    {
        return this[this.length-2];
    }

    public inline function height() : Int
    {
        return this[this.length-1];
    }

    public inline function fill(x :Int, y :Int, targetColor :Int, replacementColor :Int) : Void
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

    public inline function draw(framebuffer :kha.Framebuffer, x :Float, y :Float, pixelWidth :Float, pixelHeight :Float) : Void
    {
        for(i in 0...this.length-2) {
            framebuffer.g2.color = this[i];
            var pX = i%width();
            var pY = Math.floor(i/width());
            framebuffer.g2.fillRect(x + pX * pixelWidth, y + pY * pixelHeight, pixelWidth, pixelHeight);
            framebuffer.g2.color = 0xff000000;
            framebuffer.g2.drawRect(x + pX * pixelWidth, y + pY * pixelHeight, pixelWidth, pixelHeight);
        }
    }

    public inline function isLeftWall(x :Int) : Bool
    {
        return x == 0;
    }

    public inline function isRightWall(x :Int) : Bool
    {
        return x == width() - 1;
    }

    public inline function isTopWall(y :Int) : Bool
    {
        return y == 0;
    }

    public inline function isBottomWall(y :Int) : Bool
    {
        return y == height() - 1;
    }
}