package cosmo.util;

abstract Signal0(Array<Void->Void>) 
{
    public inline function new() : Void
    {
        this = [];
    }

    public inline function emit() : Void
    {
        for (listener in this) {
            listener();
        }
    }

    public inline function connect(fn :Void->Void) : Void
    {
        this.push(fn);
    }
}