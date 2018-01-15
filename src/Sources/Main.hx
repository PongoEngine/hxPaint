/*
 * Copyright (c) 2017 Jeremy Meltingtallow
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
import jasper.*;
import hxPaint.Box;
import hxPaint.WindowBox;
import hxPaint.LeftPanel;
import hxPaint.RightPanel;
import hxPaint.MainPanel;

class Main {
    public static function main() : Void
    {
        System.init({title: "jasper-example", width: 800, height: 600}, function() {
            var width = System.windowWidth();
            var height = System.windowHeight();

            var window = new WindowBox(0xff444444, width, height, new Solver());
            window.addChild(new LeftPanel(0xffaaaaaa));
            window.addChild(new RightPanel(0xffaaaaaa));
            window.addChild(new MainPanel(0xffffffff));


            window.solver.updateVariables();

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(0xffffffff);
                Box.render(window, framebuffer);
                framebuffer.g2.end();
            });

            var _isDown :Bool = false;
            kha.input.Mouse.get().notify(function(b,x,y) {
                _isDown = true;
                window.solver.suggestValue(window.width, x);
                window.solver.suggestValue(window.height, y);
                window.solver.updateVariables();
            }, function(b,x,y) {
                _isDown = false;
            }, function(x,y,cX,cY) {
                if(_isDown) {
                    window.solver.suggestValue(window.width, x);
                    window.solver.suggestValue(window.height, y);
                    window.solver.updateVariables();
                }
                
            }, function(c) {
            });
        });
    }
}