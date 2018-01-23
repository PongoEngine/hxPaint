package cosmo.style;

import jasper.Variable;
import jasper.Expression;

enum Constraint
{
    INHERIT;
    PX(val :Float);
    FUNC(val :Variable -> Expression);
}