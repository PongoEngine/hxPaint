package wanda.program;

import cosmo.Cosmo;
import cosmo.element.Element;
import wanda.virtual.Virtual;
import wanda.virtual.VElement;

class Program<Model, Msg>
{
    public function new(model :Model, updateFn :Msg -> Model -> Void, viewFn : Model -> VElement) : Void
    {
        _model = model;
        _updateFn = updateFn;
        _viewFn = viewFn;

        _oldView = null;
        _cosmo = new Cosmo();
        
        processView(_model);
    }

    public function update(msg :Msg) : Void
    {
        _updateFn(msg, _model);
        processView(_model);
    }

    public function render(framebuffer :kha.Framebuffer) : Void
    {
        _cosmo.render(framebuffer);
    }

    private function processView(model :Model) : Void
    {
        var nView = _viewFn(_model);
        var hasChanged = Virtual.updateElement(update, _cosmo.root, nView, _oldView, _cosmo.root.firstChild);
        _oldView = nView;

        // update_impl(_root, model);
    }

    private var _model :Model;
    private var _updateFn :Msg -> Model -> Void;
    private var _viewFn :Model -> VElement;

    private var _oldView :VElement;
    private var _cosmo :Cosmo;
}