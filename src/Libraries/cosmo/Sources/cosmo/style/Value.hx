package cosmo.style;

import jasper.Variable;
import jasper.Expression;

enum Value
{
    INHERIT;
    PX(val :Float);
    PERCENT(val :Float);
    CALC(fn :Variable -> Expression);
}