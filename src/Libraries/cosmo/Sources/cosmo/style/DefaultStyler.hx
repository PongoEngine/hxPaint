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

package cosmo.style;

import cosmo.element.Element;

class DefaultStyler
{

    public static function setStyle(element :Element) : Element
    {
        switch element.elementType {
            case BUTTON: {
                
            }
            case CONTAINER: {
                element.style.width = PX(50);
                element.style.height = PX(80);
            }
            case ELEMENT: {

            }
            case VERTICAL_DIVIDER: {
                element.style.width = PX(20);
                element.style.height = PX(290);
            }
            case WINDOW: {
                element.style.width = PX(kha.System.windowWidth()/2);
                element.style.height = PX(kha.System.windowHeight());
            }
        }

        return element;
    }

}