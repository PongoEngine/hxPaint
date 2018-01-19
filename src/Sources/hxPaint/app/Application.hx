package hxPaint.app;

import hxPaint.ui.WindowBox;
import hxPaint.ui.Box;

class Application
{
    public function new(model :Model, window :WindowBox) : Void
    {
        _model = model;
        _window = window;
    }

    public function setPencil() : Void
    {
        _model.operation = PENCIL;
        _model.pencil.isOn = true;
        _model.fill.isOn = false;
        _model.eraser.isOn = false;
        Box.update(_window, _model);
    }

    public function setFill() : Void
    {
        _model.operation = FILL;
        _model.pencil.isOn = false;
        _model.fill.isOn = true;
        _model.eraser.isOn = false;
        Box.update(_window, _model);
    }

    public function setEraser() : Void
    {
        _model.operation = ERASER;
        _model.pencil.isOn = false;
        _model.fill.isOn = false;
        _model.eraser.isOn = true;
        Box.update(_window, _model);
    }

    public function setColor(color :Int) : Void
    {
        _model.color = color;
        Box.update(_window, _model);
    }

    public function fillPixel(x :Int, y :Int) : Void
    {
        var target = _model.pixels.getColor(x,y);
        _model.pixels.fill(x,y, target, _model.color);
        Box.update(_window, _model);
    }

    public function colorPixel(x :Int, y :Int) : Void
    {
        _model.pixels.setColor(x,y, _model.color);
        Box.update(_window, _model);
    }

    private var _model :Model;
    private var _window :WindowBox;
}