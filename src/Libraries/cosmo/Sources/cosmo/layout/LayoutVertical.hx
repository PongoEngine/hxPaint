package cosmo.layout;

import jasper.Constraint;
import cosmo.element.Element;
import cosmo.layout.LayoutDefs.*;

using cosmo.layout.LayoutTools;

class LayoutVertical
{
    public static function layout(element :Element) : Void
    {
        var constraints = element._constraints;
        var parent = element.parentElement;

        layoutWidth(element, parent, constraints);
        layoutHeight(element, parent, constraints);
        layoutX(element, parent, constraints);
        layoutY(element, parent, constraints);
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutWidth(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.width {
            case INHERIT: constraints.push((element.width == parent.width) | INHERIT_STRENGTH);
            case PX(val): constraints.push((element.width == val) | PX_STRENGTH);
        }
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutHeight(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.height {
            case INHERIT: constraints.push((element.height == 0) | INHERIT_STRENGTH);
            case PX(val): constraints.push((element.height == val) | PX_STRENGTH);
        }
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutX(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.x {
            case INHERIT: constraints.push((element.left() == parent.left()) | INHERIT_STRENGTH);
            case PX(val): constraints.push((element.left() == parent.left() + val) | PX_STRENGTH);
        }
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutY(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        if(parent.firstChild == null) {
            switch element.style.y {
                case INHERIT: constraints.push((element.top() == parent.top()) | INHERIT_STRENGTH);
                case PX(val): constraints.push((element.top() == parent.top() + val) | PX_STRENGTH);
            }
        }
        else {
            var prevSib = parent.lastChild();
            switch element.style.y {
                case INHERIT: constraints.push((element.top() == prevSib.bottom()) | INHERIT_STRENGTH);
                case PX(val): constraints.push((element.top() == prevSib.bottom() + val) | PX_STRENGTH);
            }
        }
    }
}