package hxPaint;

import jasper.Solver;
import hxPaint.Operation;

class Button extends Box
{
    public var operation :Operation;
    public var solver :Solver;

    public function new(operation :Operation, solver :Solver) : Void
    {
        super();
        this.operation = operation;
        this.solver = solver;
        _textAnchorX = Main.font.width(Main.fontSize, operation.toString())/2;
        _textAnchorY = Main.font.height(Main.fontSize)/2;
    }

    override public function onDown(x :Int,y :Int) : Void
    {
        Main.operation = operation;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        
        if(prev == null) {
            solver.addConstraint(this.y == parent.y + 5);
        }
        else {
            solver.addConstraint(this.y == prev.y + prev.height + 5);
        }
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }

    override public function draw(framebuffer :kha.Framebuffer) : Void
    {
        framebuffer.g2.color = Main.operation == this.operation ? Main.color : 0xff444444;
        framebuffer.g2.fillRect(x.m_value, y.m_value, width.m_value, height.m_value);
        framebuffer.g2.color = 0xff000000;
        framebuffer.g2.drawString(this.operation.toString(), x.m_value + width.m_value/2 - _textAnchorX, y.m_value + height.m_value/2 - _textAnchorY);
    }

    private var _textAnchorX :Float;
    private var _textAnchorY :Float;
}