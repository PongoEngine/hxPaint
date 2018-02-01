/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package hxPaint;

import hxPaint.element.Rectangle;
import hxPaint.element.Window;
import hxPaint.input.Mouse;
import hxPaint.layout.Layout;
import jasper.Variable;

class Paint
{
    public var window :Window;

    public function new(width :Int, height :Int) : Void
    {
        _width = width;
        _height = height;
        window = new Window(this, _width, _height);
        new Mouse(window);
        _layout = new Layout(window);
    }

    public function render(width :Int, height :Int, framebuffer :kha.Framebuffer) : Void
    {
        if(_width != width || _height != height) {
            window.resize(width, height);
            _width = width;
            _height = height;   
        }
        render_impl(window, framebuffer);
    }

    public function update(dt :Float) : Void
    {
        update_impl(window, dt);
    }

    public inline function suggest(variable :Variable, value :Float) : Void
    {
        _layout.suggest(variable, value);
    }

    public inline function initLayout() : Void
    {
        _layout.initLayout();
    }

    public inline function updateLayout() : Void
    {
        _layout.updateLayout();
    }

    public static function render_impl(element :Rectangle, framebuffer :kha.Framebuffer)
    {
        framebuffer.g2.scissor(Math.round(element.x.m_value), Math.round(element.y.m_value), Math.round(element.width.m_value), Math.round(element.height.m_value));
        element.draw(framebuffer);
        for(child in element.children) {
            render_impl(child, framebuffer);
        }
    }

    public static function update_impl(element :Rectangle, dt :Float)
    {
        element.update(dt);
        for(child in element.children) {
            update_impl(child, dt);
        }
    }
    
    private var _layout :Layout;
    private var _width :Int;
    private var _height :Int;
}