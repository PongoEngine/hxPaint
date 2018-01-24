package cosmo.util;

abstract Signal1<T>(Array<T->Void>) 
{
    public inline function new() : Void
    {
        this = [];
    }

    public inline function emit(t:T) : Void
    {
        for (listener in this) {
            listener(t);
        }
    }

    public inline function connect(fn :T->Void) : Void
    {
        this.push(fn);
    }
}