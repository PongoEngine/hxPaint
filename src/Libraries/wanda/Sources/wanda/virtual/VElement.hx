package wanda.virtual;

class VElement
{
    public var nodeType (default, null):VNodeType;
    public var children :Array<VElement>;

    public function new(nodeType :VNodeType, children :Array<VElement>) : Void
    {
        this.nodeType = nodeType;
        this.children = children;
    }
}