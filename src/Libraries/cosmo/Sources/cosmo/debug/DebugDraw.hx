package cosmo.debug;

import cosmo.element.Element;

class DebugDraw
{
    public static function debugDraw(element :Element, framebuffer :kha.Framebuffer)
    {
        element.draw(framebuffer);

        var p = element.firstChild;
        while (p != null) {
            var next = p.nextSibling;
            debugDraw(p, framebuffer);
            p = next;
        }
    }
}