package perdita;

import jasper.Variable;
import jasper.Expression;

enum ValueConstraint
{
    PX(val :Float);
    PERCENT(val :Float);
    CALC(variable :Variable -> Expression);
    INHERIT;
}