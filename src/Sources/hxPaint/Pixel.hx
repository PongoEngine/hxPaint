package hxPaint;

import jasper.Solver;

class Pixel extends Box
{
    public var index :Int;
    public var rowLength :Int;
    public var isColored :Bool;
    public var color :Int;
    public var up :Pixel;
    public var right :Pixel;
    public var down :Pixel;
    public var left :Pixel;

    public function new(solver :Solver, rowLength :Int, index :Int) : Void
    {
        super(solver);
        this.index = index;
        this.rowLength = rowLength;
        this.isColored = false;
    }

    override public function onDown(x:Int, y:Int) : Void
    {
        switch Main.operation {
            case PENCIL: pencil();
            case FILL: fill(this, this.color, Main.color);
            case ERASER:
        }
    }

    private function pencil() : Void
    {
        if(this.color != Main.color && isColored) {
            this.color = Main.color;
        }
        else if(isColored) {
            this.isColored = false;
        }
        else {
            this.isColored = true;
            this.color = Main.color;
        }
    }

    private function fill(pixel :Pixel, targetColor :Int, replacementColor :Int) : Void
    {
        if(pixel == null) return;
        if(targetColor == replacementColor) return;
        if(pixel.color != targetColor) return;
        pixel.color = replacementColor;
        pixel.isColored = true;

        fill(pixel.down, targetColor, replacementColor);
        fill(pixel.up, targetColor, replacementColor);
        fill(pixel.left, targetColor, replacementColor);
        fill(pixel.right, targetColor, replacementColor);
        return;
    }

    override public function onSolved() : Void
    {
        var x = index%this.rowLength;
        var y = Math.floor(index/this.rowLength);
        var pixelSize = parent.width.m_value/rowLength;
        this.x.m_value = parent.x.m_value + (x * pixelSize);
        this.y.m_value = parent.y.m_value + (y * pixelSize);
        this.width.m_value = pixelSize;
        this.height.m_value = pixelSize;
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        if(isColored) {
            framebuffer.g2.color = this.color;
            framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        }
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawRect(x.m_value, y.m_value, width.m_value, height.m_value);
    }
}