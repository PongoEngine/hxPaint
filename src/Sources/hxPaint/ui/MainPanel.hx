package hxPaint.ui;

import jasper.Solver;
import hxPaint.app.Model;

class MainPanel extends Box
{
    public var color :Int;
    public var solver :Solver;

    public function new(solver :Solver, color :Int, model :Model, fnPencil : Int -> Int -> Void, fnFill : Int -> Int -> Void) : Void
    {
        super();
        this.color = color;
        this.solver = solver;
        _model = model;
        _pixelsWidth = 0;
        _pixelHeight = 0;
        _fnPencil = fnPencil;
        _fnFill = fnFill;
        _isDown = false;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == 120);
        solver.addConstraint(this.y == parent.y + 10);
        solver.addConstraint(this.width == parent.width - 240);
        solver.addConstraint((this.height == parent.height - 20));
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        trace(_model.operation);
        switch _model.operation {
            case PENCIL: colorPixel(x,y);
            case FILL: fillPixel(x,y);
            case ERASER:
        }
        _isDown = true;
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        _isDown = false;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            switch _model.operation {
                case PENCIL: colorPixel(x,y);
                case FILL:
                case ERASER:
            }
        }
    }

    override public function onSolved() : Void
    {
        _pixelHeight = _pixelsWidth = this.width.m_value / _model.pixels.width();
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        _model.pixels.draw(framebuffer, this.x.m_value, this.y.m_value, _pixelsWidth, _pixelHeight);
    }

    private function colorPixel(x :Int, y :Int) : Void
    {
        var xIndex :Int = Math.floor((x-this.x.m_value) / _pixelsWidth);
        var yIndex :Int = Math.floor((y-this.y.m_value) / _pixelHeight);
        if(xIndex < _model.pixels.width() && yIndex < _model.pixels.height()) {
            _fnPencil(xIndex, yIndex);
        }
    }

    private function fillPixel(x :Int, y :Int) : Void
    {
        var xIndex :Int = Math.floor((x-this.x.m_value) / _pixelsWidth);
        var yIndex :Int = Math.floor((y-this.y.m_value) / _pixelHeight);
        if(xIndex < _model.pixels.width() && yIndex < _model.pixels.height()) {
            _fnFill(xIndex, yIndex);
        }
    }

    private var _pixelsWidth :Float;
    private var _pixelHeight :Float;
    private var _model :Model;
    private var _fnPencil : Int -> Int -> Void;
    private var _fnFill : Int -> Int -> Void;
    private var _isDown :Bool;
}