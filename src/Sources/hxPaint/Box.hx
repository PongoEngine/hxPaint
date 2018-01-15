package hxPaint;

import jasper.Variable;
import jasper.Solver;

class Box
{
    public var parent (default, null) :Box = null;
    public var firstChild (default, null) :Box = null;
    public var next (default, null) :Box = null;
    public var prev (default, null) :Box = null;
    public var solver (default, null) :Solver = null;

    public var x :Variable;
    public var y :Variable;
    public var width :Variable;
    public var height :Variable;

    public function new(solver :Solver) : Void
    {
        x = new Variable();
        y = new Variable();
        width = new Variable();
        height = new Variable();
        this.solver = solver;
    }

    public function onAdded() : Void
    {
    }

    public function draw(framebuffer :kha.Framebuffer) : Void
    {
    }

    public function addChild (child :Box) :Box
    {
        child.parent = this;

        var tail = null, p = firstChild;
        while (p != null) {
            tail = p;
            p = p.next;
        }
        if (tail != null) {
            tail.next = child;
            child.prev = tail;
        } else {
            firstChild = child;
        }

        child.onAdded();

        return this;
    }

    public static function render (box :Box, framebuffer :kha.Framebuffer)
    {
        box.draw(framebuffer);

        var p = box.firstChild;
        while (p != null) {
            var next = p.next;
            render(p, framebuffer);
            p = next;
        }
    }
}