package hxPaint.app;

import hxPaint.ui.WindowBox;
import hxPaint.ui.Box;

class Application
{
    public function new(msg :Msg, model :Model, window :WindowBox, update :Msg -> Model -> Model) : Void
    {
        _model = model;
        _window = window;
        _update = update;
        this.update(msg);
    }

    public function update(msg :Msg) : Void
    {
        _model = _update(msg, _model);
        Box.update(_window, _model);
    }

    private var _model :Model;
    private var _window :WindowBox;
    private var _update :Msg -> Model -> Model;
}