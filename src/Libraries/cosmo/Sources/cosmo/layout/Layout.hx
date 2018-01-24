package cosmo.layout;

import cosmo.style.Direction;
import cosmo.element.Element;
import jasper.Constraint;
import jasper.Strength;

class Layout
{
    /**
     *  [Description]
     *  @param element - 
     *  @return Array<Constraint>
     */
    public static function layout(element :Element) : Array<Constraint>
    {
        var constraints = [];
        
        var parent = element.parentElement;
        layoutX(parent.style.direction, element, parent, constraints);
        layoutY(parent.style.direction, element, parent, constraints);
        layoutWidth(parent.style.direction, element, parent, constraints);
        layoutHeight(parent.style.direction, element, parent, constraints);

        return constraints;
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutWidth(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.width {
            case INHERIT: switch direction {
                case VERTICAL: constraints.push((element.width == parent.width) | Strength.WEAK);
                case HORIZONTAL: constraints.push((element.width == 0) | Strength.WEAK);
            }
            case PX(val): constraints.push((element.width == val ) | Strength.REQUIRED);
        }
        constraints.push((parent.width + parent.x >= element.width + element.x) | Strength.MEDIUM);
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutHeight(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.height {
            case INHERIT: switch direction {
                case VERTICAL: constraints.push((element.height == 0) | Strength.WEAK);
                case HORIZONTAL: constraints.push((element.height == parent.height) | Strength.WEAK);
            }
            case PX(val): constraints.push((element.height == val ) | Strength.REQUIRED);
        }
        constraints.push((parent.height + parent.y >= element.height + element.y) | Strength.MEDIUM);
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutX(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch [direction, element.style.x] {
            case [VERTICAL, INHERIT]: constraints.push(element.x == parent.x);
            case [VERTICAL, PX(val)]: constraints.push(element.x == parent.x + val);
            case [HORIZONTAL, INHERIT]: {
                layoutX_Relative(element, parent, 0, constraints);
            }
            case [HORIZONTAL, PX(val)]: {
                layoutX_Relative(element, parent, val, constraints);
            }
        }
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param val - 
     *  @param constraints - 
     */
    public static function layoutX_Relative(element :Element, parent :Element, val :Float, constraints :Array<Constraint>) : Void
    {
        if((parent.firstChild == null)) {
            constraints.push(element.x == parent.x + val);
        }
        else {
            var lastChild = parent.lastChild();
            constraints.push(element.x == lastChild.x + lastChild.width + val);
        }
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutY(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch [direction, element.style.y] {
            case [HORIZONTAL, INHERIT]: constraints.push(element.y == parent.y);
            case [HORIZONTAL, PX(val)]: constraints.push(element.y == parent.y + val);
            case [VERTICAL, INHERIT]: {
                layoutY_Relative(element, parent, 0, constraints);
            }
            case [VERTICAL, PX(val)]: {
                layoutY_Relative(element, parent, val, constraints);
            }
        }
    }

    /**
     *  [Description]
     *  @param element - 
     *  @param parent - 
     *  @param val - 
     *  @param constraints - 
     */
    public static function layoutY_Relative(element :Element, parent :Element, val :Float, constraints :Array<Constraint>) : Void
    {
        if((parent.firstChild == null)) {
            constraints.push(element.y == parent.y + val);
        }
        else {
            var lastChild = parent.lastChild();
            constraints.push(element.y == lastChild.y + lastChild.height + val);
        }
    }
}