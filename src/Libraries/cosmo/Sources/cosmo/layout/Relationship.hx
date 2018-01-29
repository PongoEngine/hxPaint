package cosmo.layout;

@:enum
abstract Relationship(Int)
{
    var FIRST_CHILD = 0;
    var LAST_CHILD = 1;
}