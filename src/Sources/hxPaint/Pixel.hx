package hxPaint;

import jasper.Solver;

class Pixel extends Box
{
    public var index :Int;
    public var rowLength :Int;
    public var isColored :Bool;
    public var color :Int;

    public function new(solver :Solver, rowLength :Int, index :Int) : Void
    {
        super(solver);
        this.index = index;
        this.rowLength = rowLength;
        this.isColored = false;
    }

    override public function onDown(x:Int, y:Int) : Void
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