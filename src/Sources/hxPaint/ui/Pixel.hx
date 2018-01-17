package hxPaint.ui;

import jasper.Solver;

class Pixel extends Box
{
    public var xIndex :Int;
    public var yIndex :Int;
    public var rowLength :Int;
    public var color :Int;

    public static var CAN_PENCIL :Bool = false;
    public static var CAN_ERASE :Bool = false;

    public function new(solver :Solver, xIndex :Int, yIndex :Int, rowLength :Int) : Void
    {
        super();
        this.color = 0xffffffff;
        this.xIndex = xIndex;
        this.yIndex = yIndex;
        this.rowLength = rowLength;
    }

    override public function onDown(x:Int, y:Int) : Void
    {
        switch Main.operation {
            case PENCIL: {
                CAN_PENCIL = true;
                pencil();
            }
            case FILL: fill(this, this.color, Main.color);
            case ERASER: {
                CAN_ERASE = true;
                erase();
            }
        }
    }

    override public function onUp(x:Int, y:Int) : Void
    {
        CAN_PENCIL = false;
        CAN_ERASE = false;
    }

    override public function onMove(x:Int, y:Int) : Void
    {
        if(CAN_PENCIL) {
            pencil();
        }
        if(CAN_ERASE) {
            erase();
        }
    }

    private function pencil() : Void
    {
        this.color = Main.color;
    }

    private function erase() : Void
    {
        this.color = 0xffffffff;
    }

    private static function fill(pixel :Pixel, targetColor :Int, replacementColor :Int) : Void
    {
        if(targetColor == replacementColor) return;
        if(pixel.color != targetColor) return;
        pixel.color = replacementColor;

        if(!pixel.isBottomWall()) {
            var pixel = Main.pixels[(pixel.yIndex+1)*pixel.rowLength + pixel.xIndex];
            fill(pixel, targetColor, replacementColor);
        }
        if(!pixel.isTopWall()) {
            var pixel = Main.pixels[(pixel.yIndex-1)*pixel.rowLength + pixel.xIndex];
            fill(pixel, targetColor, replacementColor);
        }
        if(!pixel.isLeftWall()) {
            var pixel = Main.pixels[pixel.yIndex*pixel.rowLength + pixel.xIndex - 1];
            fill(pixel, targetColor, replacementColor);
        }
        if(!pixel.isRightWall()) {
            var pixel = Main.pixels[pixel.yIndex*pixel.rowLength + pixel.xIndex + 1];
            fill(pixel, targetColor, replacementColor);
        }
        
        return;
    }

    public inline function isLeftWall() : Bool
    {
        return xIndex == 0;
    }

    public inline function isRightWall() : Bool
    {
        return xIndex == rowLength - 1;
    }

    public inline function isTopWall() : Bool
    {
        return yIndex == 0;
    }

    public inline function isBottomWall() : Bool
    {
        return yIndex == rowLength - 1;
    }

    override public function onSolved() : Void
    {
        var pixelSize = parent.width.m_value/rowLength;
        this.x.m_value = parent.x.m_value + (xIndex * pixelSize);
        this.y.m_value = parent.y.m_value + (yIndex * pixelSize);
        this.width.m_value = pixelSize;
        this.height.m_value = pixelSize;
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}