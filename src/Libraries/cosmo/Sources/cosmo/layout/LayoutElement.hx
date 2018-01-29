package cosmo.layout;

import jasper.Solver;
import jasper.Constraint;
import jasper.Strength;
import cosmo.element.Element;

using cosmo.layout.LayoutTools;

class LayoutElement
{
    public function new(solver :Solver, element :Element) : Void
    {
        _solver = solver;
        _element = element;

        _styledConstraints = [];
        _heightConstraint = new Map<Element, Constraint>();
    }

    public function setStyledConstraints() : Void
    {
        if(_styledConstraints.length > 0) {
            for(s in _styledConstraints) {
                _solver.removeConstraint(s);
            }
            _styledConstraints = [];
        }

        switch _element.style.width {
            case PX(val): _styledConstraints.push((_element.width == val) | Strength.MEDIUM);
            case INHERIT: _styledConstraints.push((_element.width == 0) | Strength.WEAK);
        }

        switch _element.style.height {
            case PX(val): _styledConstraints.push((_element.height == val) | Strength.MEDIUM);
            case INHERIT: _styledConstraints.push((_element.height == _element.parentElement.height) | Strength.WEAK);
        }

        for(s in _styledConstraints) {
            _solver.addConstraint(s);
        }
    }

    public function setXConstraintFromSibling(prevSibling :Element) : Void
    {
        if(_xConstraint != null) {
            _solver.removeConstraint(_xConstraint);
        }
        _xConstraint = (_element.left() == prevSibling.right()) | Strength.REQUIRED;
        _solver.addConstraint(_xConstraint);
    }

    public function setXConstraintFromParent(parent :Element) : Void
    {
        if(_xConstraint != null) {
            _solver.removeConstraint(_xConstraint);
        }
        _xConstraint = (_element.left() == parent.left()) | Strength.REQUIRED;
        _solver.addConstraint(_xConstraint);
    }

    public function setYConstraint(parent :Element) : Void
    {
        if(_yConstraint != null) {
            _solver.removeConstraint(_yConstraint);
        }
        _yConstraint = (_element.top() == parent.top()) | Strength.REQUIRED;
        _solver.addConstraint(_yConstraint);
    }

    public function setWidthConstraint(child :Element) : Void
    {
        if(_widthConstraint != null) {
            _solver.removeConstraint(_widthConstraint);
        }
        _widthConstraint = (_element.right() == child.right()) | Strength.WEAK;
        _solver.addConstraint(_widthConstraint);
    }

    public function addHeightConstraint(child :Element) : Void
    {
        if(_heightConstraint.exists(child)) {
            var cn = _heightConstraint.get(child);
            _solver.removeConstraint(cn);
        }

        var cn = (_element.bottom() >= child.bottom()) | Strength.WEAK;
        _solver.addConstraint(cn);
        _heightConstraint.set(child, cn);
    }

    private var _solver :Solver;
    private var _element :Element;

    private var _styledConstraints : Array<Constraint>;
    private var _xConstraint : Constraint = null;
    private var _yConstraint : Constraint = null;
    private var _widthConstraint : Constraint = null;
    private var _heightConstraint : Map<Element, Constraint>;
}