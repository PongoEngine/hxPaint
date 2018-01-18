package hxPaint.ui.button;

import jasper.Solver;
import hxPaint.app.Model;

class ButtonFill extends Button
{
    public var solver :Solver;

    public function new(solver :Solver, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
    }

    override public function onUpdate(model :Model) : Void
    {
        this.isOn = model.fill.isOn;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        solver.addConstraint(this.y == prev.y + prev.height + 40);
        
        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);
        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }
}