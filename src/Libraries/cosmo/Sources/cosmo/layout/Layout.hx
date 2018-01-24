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

        layoutMinWidth(parent.style.direction, element, parent, constraints);
        layoutMaxWidth(parent.style.direction, element, parent, constraints);
        layoutWidth(parent.style.direction, element, parent, constraints);

        layoutMinHeight(parent.style.direction, element, parent, constraints);
        layoutMaxHeight(parent.style.direction, element, parent, constraints);
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
            case PX(val, str): constraints.push((element.width == val ) | str);
            case PERCENT(val, str): constraints.push((element.width == parent.width * val ) | str);
            case CALC(fn, str): constraints.push((element.width == fn(parent.width) ) | str);
        }
        constraints.push((parent.width + parent.x >= element.width + element.x) | Strength.WEAK);
    }

    public static function layoutMinWidth(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.minWidth {
            case INHERIT:
            case PX(val, str): constraints.push((element.width >= val ) | str);
            case PERCENT(val, str): constraints.push((element.width >= parent.width * val ) | str);
            case CALC(fn, str): constraints.push((element.width >= fn(parent.width) ) | str);
        }
    }

    public static function layoutMaxWidth(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.maxWidth {
            case INHERIT:
            case PX(val, str): constraints.push((element.width <= val ) | str);
            case PERCENT(val, str): constraints.push((element.width <= parent.width * val ) | str);
            case CALC(fn, str): constraints.push((element.width <= fn(parent.width) ) | str);
        }
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
            case PX(val, str): constraints.push((element.height == val ) | str);
            case PERCENT(val, str): constraints.push((element.height == parent.height * val ) | str);
            case CALC(fn, str): constraints.push((element.height == fn(parent.height) ) | str);
        }
        constraints.push((parent.height + parent.y >= element.height + element.y) | Strength.WEAK);
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutMinHeight(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.minHeight {
            case INHERIT:
            case PX(val, str): constraints.push((element.height >= val ) | str);
            case PERCENT(val, str): constraints.push((element.height >= parent.height * val ) | str);
            case CALC(fn, str): constraints.push((element.height >= fn(parent.height) ) | str);
        }
    }

    /**
     *  [Description]
     *  @param direction - 
     *  @param element - 
     *  @param parent - 
     *  @param constraints - 
     */
    public static function layoutMaxHeight(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch element.style.maxHeight {
            case INHERIT:
            case PX(val, str): constraints.push((element.height <= val ) | str);
            case PERCENT(val, str): constraints.push((element.height <= parent.height * val ) | str);
            case CALC(fn, str): constraints.push((element.height <= fn(parent.height) ) | str);
        }
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
            case [VERTICAL, INHERIT]: constraints.push((element.x == parent.x) | Strength.STRONG);
            case [VERTICAL, PX(val, str)]: constraints.push((element.x == parent.x + val) | str);
            case [VERTICAL, PERCENT(val, str)]: constraints.push((element.x == parent.x + (val * parent.width)) | str);
            case [VERTICAL, CALC(fn, str)]: constraints.push((element.x == parent.x + fn(parent.width)) | str);
            case [HORIZONTAL, INHERIT]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x;
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width;
                }, Strength.STRONG, constraints);

            case [HORIZONTAL, PX(val, str)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + val;
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + val;
                }, str, constraints);

            case [HORIZONTAL, PERCENT(val, str)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + (val * parent.width);
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + (val * parent.width);
                }, str, constraints);

            case [HORIZONTAL, CALC(fn, str)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + fn(parent.width);
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + fn(parent.width);
                }, str, constraints);
            
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
            case [HORIZONTAL, INHERIT]: constraints.push((element.y == parent.y) | Strength.STRONG);
            case [HORIZONTAL, PX(val, str)]: constraints.push((element.y == parent.y + val) | str);
            case [HORIZONTAL, PERCENT(val, str)]: constraints.push((element.y == parent.y + (val * parent.height)) | str);
            case [HORIZONTAL, CALC(fn, str)]: constraints.push((element.y == parent.y + fn(parent.height)) | str);
            case [VERTICAL, INHERIT]: 
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y;
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height;
                }, Strength.STRONG, constraints);

            case [VERTICAL, PX(val, str)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + val;
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + val;
                }, str, constraints);

            case [VERTICAL, PERCENT(val, str)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + (val * parent.height);
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + (val * parent.height);
                }, str, constraints);

            case [VERTICAL, CALC(fn, str)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + fn(parent.height);
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + fn(parent.height);
                }, str, constraints);
        }
    }

    /**
     *  [Description]
     *  @param parent - 
     *  @param fn1 - 
     *  @param fn2 - 
     *  @param constraints - 
     */
    public static function layoutRelative(parent :Element, fn1 : Element -> Constraint, fn2 : Element -> Constraint, strength :Strength, constraints :Array<Constraint>) : Void
    {
        if((parent.firstChild == null)) {
            constraints.push(fn1(parent) | strength);
        }
        else {
            constraints.push(fn2(parent.lastChild()) | strength);
        }
    }
}