package hxPaint.ui.button;

import jasper.Solver;

class ButtonColor extends Button
{
    public var solver :Solver;
    public var index :Int;

    public function new(solver :Solver, index :Int, onClick : Void -> Void) : Void
    {
        super(onClick);
        this.solver = solver;
        this.index = index;
        this.color = 0xffdd00dd;
        this.shadow = 0xffbb00bb;
    }

    override public function onAdded() : Void
    {
        solver.addConstraint(this.x == parent.x + (this.index * (parent.width/3)) + 1);
        solver.addConstraint(this.y == parent.y + parent.height + 4);
        
        solver.addConstraint(this.width == parent.width/3 - 2);
        solver.addConstraint(this.height == parent.width/3);
    }
}