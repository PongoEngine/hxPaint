package wanda.virtual;

import cosmo.element.*;
import cosmo.Cosmo;

class Virtual
{
    public static function updateElement<Model, Msg>(updateFn :Msg -> Void, parent :Element, newNode :VElement, oldNode :VElement, target :Element) : Bool
    {
        var hasChanged = false;
        if (oldNode == null) {
            parent.appendChild(
                createElement(updateFn, newNode)
            );
        }
        else if (newNode == null) {
            parent.removeChild(target);
        } 
        else if (changed(newNode, oldNode)) {
            hasChanged = true;
            parent.replaceChild(
                createElement(updateFn, newNode),
                target
            );
        } 
        else {
            var length = Virtual.max(newNode.children.length, oldNode.children.length);
            var p = target.firstChild;
            for(i in 0...length) {
                var next = (p==null) ? null : p.nextSibling;
                if (updateElement(
                    updateFn,
                    target,
                    newNode.children[i],
                    oldNode.children[i],
                    p
                )) {hasChanged = true;}
                p = next;
            }
        }

        return hasChanged;
    }

    inline static function changed<Msg>(node1 :VElement, node2 :VElement) : Bool
    {
        return !(node1.nodeType == node2.nodeType);
    }

    private static function createElement<Msg>(updateFn :Msg -> Void, dElem :VElement) : Element
    {
        var element :Element = Cosmo.createElement(dElem.style, dElem.nodeType);

        for(c in dElem.children) {
            element.appendChild(createElement(updateFn, c));
        }
        return element;
    }

    inline public static function max<T:Float> (a :T, b :T) :T
    {
        return (a > b) ? a : b;
    }
}