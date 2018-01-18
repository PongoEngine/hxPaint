package hxPaint.ui.button;

import jasper.Solver;
import hxPaint.app.Model;

class ButtonPencil extends Button
{
    public var solver :Solver;

    public function new(solver :Solver, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
    }

    override public function onUpdate(model :Model) : Void
    {
        this.isOn = model.pencil.isOn;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + 5);
        solver.addConstraint(this.y == parent.y + 5);

        solver.addConstraint(this.width == parent.width - 10);
        solver.addConstraint(this.height == parent.width - 10);

        solver.addConstraint(parent.height >= this.height + this.y - 5);
    }}