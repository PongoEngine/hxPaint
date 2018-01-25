package cosmo.layout;

import cosmo.element.Element;

class Layout
{
    public static function layout(element :Element) : Void
    {
        switch element.parentElement.style.direction {
            case VERTICAL: LayoutVertical.layout(element);
            case HORIZONTAL: LayoutHorizontal.layout(element);
        }

        for(constraint in element._constraints) {
            Cosmo.solver.addConstraint(constraint);
        }


        Cosmo.solver.updateVariables();
    }


}