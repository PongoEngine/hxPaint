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

import hxPaint.Rectangle;
import jasper.Solver;

class Main 
{
    public static function main() : Void
    {
        System.init({title: "hxPaint", width: 1366, height: 768}, function() {

            var solver = new Solver();
            var mainWindow = new Rectangle();
            solver.addConstraint(mainWindow.x == 0);
            solver.addConstraint(mainWindow.y == 0);
            solver.addConstraint(mainWindow.width == kha.System.windowWidth());
            solver.addConstraint(mainWindow.height == kha.System.windowHeight());
            solver.updateVariables();            

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(0xffffffff);
                mainWindow.draw(framebuffer);
                framebuffer.g2.end();
            });
        });
    }

    

    
}