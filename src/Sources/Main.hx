/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package;

import kha.System;

import hxPaint.Paint;
import hxPaint.LeftColumn;
import hxPaint.PixelContainer;
import hxPaint.Button;

class Main 
{
    public static function main() : Void
    {
        System.init({title: "hxPaint", width: 1366, height: 768}, function() {

            var paint = new Paint();
            paint.window
                .addChild(new LeftColumn()
                    .addChild(new Button())
                    .addChild(new Button())
                    .addChild(new Button()))
                .addChild(new PixelContainer());

            paint.solve();
            trace(paint.window.x, paint.window.y, paint.window.width, paint.window.height);

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(0xffffffff);
                paint.render(framebuffer);
                framebuffer.g2.end();
            });
        });
    }

    

    
}