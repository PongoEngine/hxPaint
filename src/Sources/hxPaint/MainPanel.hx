package hxPaint;

import jasper.Solver;
import Main.ColorRef;

class MainPanel extends Box
{
    public var color :Int;

    public function new(solver :Solver, colorRef :ColorRef, color :Int) : Void
    {
        super(solver);
        this.color = color;
        _points = [];
        _isDown = false;
        _colorRef = colorRef;
    }

    override public function onUp(x :Int, y :Int) : Void
    {
        _isDown = false;
    }

    override public function onMove(x :Int, y :Int) : Void
    {
        if(_isDown) {
            _points.push(_colorRef.val);
            _points.push(x);
            _points.push(y);
        }
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        _isDown = true;
        _points.push(_colorRef.val);
        _points.push(x);
        _points.push(y);
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == 120);
        solver.addConstraint(this.y == parent.y + 10);
        solver.addConstraint(this.width == parent.width - 240);
        solver.addConstraint(this.height == parent.height - 20);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = this.color;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
       

        var index = 0;
        var length = _points.length;
        while(index != length) {
            var color = _points[index];
            var x = _points[index+1];
            var y = _points[index+2];
            framebuffer.g2.color = color;
            framebuffer.g2.fillRect(x-6,y-6,12,12);
            index += 3;
        }
    }

    private var _isDown :Bool;
    private var _points :Array<Int>;
    private var _colorRef :ColorRef;
}