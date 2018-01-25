package cosmo.layout;

import jasper.Constraint;
import cosmo.element.Element;
import cosmo.element.ElementType;
import cosmo.layout.LayoutDefs.*;

using cosmo.layout.LayoutTools;

class LayoutHorizontal
{
    public static function layout(element :Element) : Void
    {
        var constraints = element._constraints;
        var parent = element.parentElement;

        layoutWidth(element, parent, constraints);
        layoutHeight(element, parent, constraints);
        layoutX(element, parent, constraints);
        layoutY(element, parent, constraints);

        constraints.push((parent.right() >= element.right()) | INHERIT_STRENGTH);
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutWidth(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch [element.style.width, element.elementType] {
            case [INHERIT, _]: constraints.push((element.width == 0) | INHERIT_STRENGTH);
            case [PX(val), VERTICAL_DIVIDER]: constraints.push((element.width == val) | REQUIRED_STRENGTH);
            case [PX(val), _]: constraints.push((element.width == val) | PX_STRENGTH);
        }
        constraints.push((element.width >= 0) | REQUIRED_STRENGTH);
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
            case INHERIT: constraints.push((element.height == parent.height) | INHERIT_STRENGTH);
            case PX(val): constraints.push((element.height == val) | PX_STRENGTH);
        }
        constraints.push((element.height >= 0) | REQUIRED_STRENGTH);
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutX(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        if(element.prevSibling == null) {
            switch [element.style.x, element.elementType] {
                case [INHERIT, _]: {
                    constraints.push((element.left() == parent.left()) | REQUIRED_STRENGTH);
                }
                case [PX(val), _]: //constraints.push((element.left() == parent.left() + val) | PX_STRENGTH);
            }
        }
        else {
            var prevSib = element.prevSibling;
            switch [element.style.x, element.elementType] {
                case [INHERIT, _]: {
                    constraints.push((element.left() == prevSib.right()) | INHERIT_STRENGTH);
                    constraints.push((element.left() >= prevSib.right()) | REQUIRED_STRENGTH);
                }
                case [PX(val), _]: //constraints.push((element.left() == prevSib.right() + val) | PX_STRENGTH);
            }
        }
        // constraints.push((element.right() <= parent.right()) | REQUIRED_STRENGTH);
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static inline function layoutY(element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.y {
            case INHERIT: constraints.push((element.top() == parent.top()) | REQUIRED_STRENGTH);
            case PX(val): constraints.push((element.top() == parent.top() + val) | REQUIRED_STRENGTH);
        }
    }
}