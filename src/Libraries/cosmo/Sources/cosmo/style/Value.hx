package cosmo.style;

import jasper.Variable;
import jasper.Strength;
import jasper.Expression;

enum Value
{
    INHERIT;
    PX(val :Float, str :Strength);
    PERCENT(val :Float, str :Strength);
    CALC(fn :Variable -> Expression, str :Strength);
}