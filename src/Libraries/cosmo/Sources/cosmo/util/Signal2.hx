package cosmo.util;

abstract Signal2<U,V>(Array<U->V->Void>) 
{
    public inline function new() : Void
    {
        this = [];
    }

    public inline function emit(u:U, v:V) : Void
    {
        for (listener in this) {
            listener(u,v);
        }
    }

    public inline function connect(fn :U->V->Void) : Void
    {
        this.push(fn);
    }
}