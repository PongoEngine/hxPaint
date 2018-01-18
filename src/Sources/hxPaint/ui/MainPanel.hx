package hxPaint.ui;

import jasper.Solver;
import hxPaint.app.Model;

class MainPanel extends Box
{
    public var color :Int;
    public var solver :Solver;

    public function new(solver :Solver, color :Int, model :Model, fnUpdate : Int -> Void) : Void
    {
        super();
        this.color = color;
        this.solver = solver;
        _pixels = new Pixels(model.pixels, model.rowLength);
        _pixelsWidth = 0;
        _pixelHeight = 0;
        _fnUpdate = fnUpdate;
        _isDown = false;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == 120);
        solver.addConstraint(this.y == parent.y + 10);
        solver.addConstraint(this.width == parent.width - 240);
        solver.addConstraint((this.height == parent.height - 20));
    }

    override public function onUpdate(model :Model) : Void
    {
        _pixels = new Pixels(model.pixels, model.rowLength);
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        colorPixel(x,y);   
        _isDown = true;
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        _isDown = false;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            colorPixel(x,y);   
        }
    }

    override public function onSolved() : Void
    {
        _pixelHeight = _pixelsWidth = this.width.m_value / _pixels.rowLength;
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        _pixels.draw(framebuffer, this.x.m_value, this.y.m_value, _pixelsWidth, _pixelHeight);
    }

    private function colorPixel(x :Int, y :Int) : Void
    {
        var xIndex :Int = Math.floor((x-this.x.m_value) / _pixelsWidth);
        var yIndex :Int = Math.floor((y-this.y.m_value) / _pixelHeight);
        var index = yIndex * _pixels.rowLength + xIndex;
        if(index < _pixels.length()) {
            _fnUpdate(index);
        }
    }

    private var _pixels :Pixels;
    private var _pixelsWidth :Float;
    private var _pixelHeight :Float;
    private var _fnUpdate : Int -> Void;
    private var _isDown :Bool;
}

private class Pixels
{
    public var rowLength :Int;

    public function new(pixels :Array<Int>, rowLength :Int) : Void
    {
        _pixels = pixels;
        this.rowLength = rowLength;
    }

    public function length() : Int
    {
        return _pixels.length;
    }

    public function draw(framebuffer :kha.Framebuffer, x :Float, y :Float, pixelWidth :Float, pixelHeight :Float) : Void
    {
        for(i in 0..._pixels.length) {
            framebuffer.g2.color = _pixels[i];
            var pX = i%this.rowLength;
            var pY = Math.floor(i/this.rowLength);
            framebuffer.g2.fillRect(x + pX * pixelWidth, y + pY * pixelHeight, pixelWidth, pixelHeight);
            framebuffer.g2.color = 0xff000000;
            framebuffer.g2.drawRect(x + pX * pixelWidth, y + pY * pixelHeight, pixelWidth, pixelHeight);
        }
    }

    private var _pixels :Array<Int>;
}