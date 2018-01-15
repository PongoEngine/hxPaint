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
            _points.push(x);
            _points.push(y);
        }
    }

    override public function onDown(x :Int, y :Int) : Void
    {
        _isDown = true;
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
        framebuffer.g2.color = 0xffff0000;
       

        var index = 0;
        var length = _points.length;
        var lastX = 0;
        var lastY = 0;

        if(length != 0) {
            lastX= _points[0];
            lastY= _points[1];
        }

        while(index != length) {
            lastX= _points[index];
            lastY= _points[index+1];

            framebuffer.g2.fillRect(lastX,lastY,4,4);

            index += 2;
        }
    }

    private var _isDown :Bool;
    private var _points :Array<Int>;
    private var _colorRef :ColorRef;
}