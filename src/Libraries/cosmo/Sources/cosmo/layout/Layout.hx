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
            case PX(val): constraints.push((element.width == val ) | Strength.MEDIUM);
            case PERCENT(val): constraints.push((element.width == parent.width * val ) | Strength.MEDIUM);
            case CALC(fn): constraints.push((element.width == fn(parent.width) ) | Strength.MEDIUM);
        }
        constraints.push((parent.width + parent.x >= element.width + element.x) | Strength.WEAK);
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
            case PX(val): constraints.push((element.height == val ) | Strength.MEDIUM);
            case PERCENT(val): constraints.push((element.height == parent.height * val ) | Strength.MEDIUM);
            case CALC(fn): constraints.push((element.height == fn(parent.height) ) | Strength.MEDIUM);
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
    public static function layoutX(direction :Direction, element :Element, parent :Element, constraints :Array<Constraint>) : Void
    {
        switch [direction, element.style.x] {
            case [VERTICAL, INHERIT]: constraints.push((element.x == parent.x) | Strength.STRONG);
            case [VERTICAL, PX(val)]: constraints.push((element.x == parent.x + val) | Strength.STRONG);
            case [VERTICAL, PERCENT(val)]: constraints.push((element.x == parent.x + (val * parent.width)) | Strength.STRONG);
            case [VERTICAL, CALC(fn)]: constraints.push((element.x == parent.x + fn(parent.width)) | Strength.STRONG);
            case [HORIZONTAL, INHERIT]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x;
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width;
                }, constraints);

            case [HORIZONTAL, PX(val)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + val;
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + val;
                }, constraints);

            case [HORIZONTAL, PERCENT(val)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + (val * parent.width);
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + (val * parent.width);
                }, constraints);

            case [HORIZONTAL, CALC(fn)]:
                layoutRelative(parent, function(parent) {
                    return element.x == parent.x + fn(parent.width);
                }, function(sibling) {
                    return element.x == sibling.x + sibling.width + fn(parent.width);
                }, constraints);
            
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
            case [HORIZONTAL, PX(val)]: constraints.push((element.y == parent.y + val) | Strength.STRONG);
            case [HORIZONTAL, PERCENT(val)]: constraints.push((element.y == parent.y + (val * parent.height)) | Strength.STRONG);
            case [HORIZONTAL, CALC(fn)]: constraints.push((element.y == parent.y + fn(parent.height)) | Strength.STRONG);
            case [VERTICAL, INHERIT]: 
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y;
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height;
                }, constraints);

            case [VERTICAL, PX(val)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + val;
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + val;
                }, constraints);

            case [VERTICAL, PERCENT(val)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + (val * parent.height);
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + (val * parent.height);
                }, constraints);

            case [VERTICAL, CALC(fn)]:
                layoutRelative(parent, function(parent) {
                    return element.y == parent.y + fn(parent.height);
                }, function(sibling) {
                    return element.y == sibling.y + sibling.height + fn(parent.height);
                }, constraints);
        }
    }

    /**
     *  [Description]
     *  @param parent - 
     *  @param fn1 - 
     *  @param fn2 - 
     *  @param constraints - 
     */
    public static function layoutRelative(parent :Element, fn1 : Element -> Constraint, fn2 : Element -> Constraint, constraints :Array<Constraint>) : Void
    {
        if((parent.firstChild == null)) {
            constraints.push(fn1(parent) | Strength.STRONG);
        }
        else {
            constraints.push(fn2(parent.lastChild()) | Strength.STRONG);
        }
    }
}