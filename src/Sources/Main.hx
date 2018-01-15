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
import hxPaint.Button;
import hxPaint.Color;

class Main 
{
    public static function main() : Void
    {
        System.init({title: "jasper-example", width: 800, height: 600}, function() {
            var width = System.windowWidth();
            var height = System.windowHeight();
            var solver = new Solver();

            var window = new WindowBox(0xff444444, width, height, solver);
            window.addChild(new LeftPanel(solver, 0xffaaaaaa)
                .addChild(new Button(solver, 0xff334455))
                .addChild(new Button(solver, 0xff334455))
                .addChild(new Button(solver, 0xff334455)));
            window.addChild(new RightPanel(solver, 0xffaaaaaa)
                .addChild(new Color(solver, 0xff000000)) //black
                .addChild(new Color(solver, 0xff808080)) //grey
                .addChild(new Color(solver, 0xffC0C0C0)) //silver
                .addChild(new Color(solver, 0xffFFFFFF)) //white
                .addChild(new Color(solver, 0xff800000)) //maroon
                .addChild(new Color(solver, 0xffFF0000)) //red
                .addChild(new Color(solver, 0xff808000)) //olive
                .addChild(new Color(solver, 0xffFFFF00)) //yellow
                .addChild(new Color(solver, 0xff008000)) //green
                .addChild(new Color(solver, 0xff00FF00)) //lime
                .addChild(new Color(solver, 0xff008080)) //teal
                .addChild(new Color(solver, 0xff00FFFF)) //aqua
                .addChild(new Color(solver, 0xff000080)) //navy
                .addChild(new Color(solver, 0xff0000FF)) //blue
                .addChild(new Color(solver, 0xff800080)) //purple
                .addChild(new Color(solver, 0xffFF00FF))); //fuchsia
            window.addChild(new MainPanel(solver, 0xffffffff));

            window.solver.updateVariables();

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(0xffffffff);
                Box.render(window, framebuffer);
                framebuffer.g2.end();
            });

            var _isDown :Bool = false;
            kha.input.Mouse.get().notify(function(b,x,y) {
                _isDown = true;
                Box.hitTest(window,x,y);
                // window.solver.suggestValue(window.width, x);
                // window.solver.suggestValue(window.height, y);
                // window.solver.updateVariables();
            }, function(b,x,y) {
                _isDown = false;
            }, function(x,y,cX,cY) {
                if(_isDown) {
                    // window.solver.suggestValue(window.width, x);
                    // window.solver.suggestValue(window.height, y);
                    // window.solver.updateVariables();
                }
                
            }, function(c) {
            });
        });
    }
}