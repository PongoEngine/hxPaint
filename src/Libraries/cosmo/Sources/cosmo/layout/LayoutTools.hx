package cosmo.layout;

import cosmo.element.Element;
import jasper.Expression;

class LayoutTools
{
    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function left(element :Element) : Expression
    {
        return element.x + 0;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function right(element :Element) : Expression
    {
        return element.x + element.width;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function top(element :Element) : Expression
    {
        return element.y + 0;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function bottom(element :Element) : Expression
    {
        return element.y + element.height;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function centerX(element :Element) : Expression
    {
        return element.x + element.width/2;
    }

    /**
     *  [Description]
     *  @param element - 
     *  @return Expression
     */
    public static function centerY(element :Element) : Expression
    {
        return element.y + element.height/2;
    }
}