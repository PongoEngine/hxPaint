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

import jasper.Solver;
import perdita.Box;
import perdita.Window;
import perdita.Style;

class Main 
{

    public static function init() : Window
    {
        var mainWindow = new Window(0xff00ff00, 800, 600);

        var leftChildStyle = new Style();
        leftChildStyle.width = PERCENT(.75);
        leftChildStyle.height = PERCENT(0.5);
        leftChildStyle.marginTop = PX(10);
        leftChildStyle.marginLeft = PX(10);

        mainWindow.addBox(new Box(0xffff0000, leftChildStyle)
            .addBox(new Box(0xff0000ff, leftChildStyle)));

        return mainWindow;
    }

    public static function main() : Void
    {
        System.init({title: "Perdita", width: 1366, height: 768}, function() {
            var mainWindow = init();
            var solver = new Solver();

            addToSolver(mainWindow._root, solver);

            solver.updateVariables();

            System.notifyOnRender(function(framebuffer) {
                framebuffer.g2.begin(true, 0xffffffff);
                mainWindow.render(framebuffer.g2);
                framebuffer.g2.end();
            });
        });
    }

    private static function addToSolver(child :Box, solver :Solver) : Void
    {
        trace(child.color);
        for(constraint in child._constraints) {
            solver.addConstraint(constraint);
        }

        for(child in child._children) {
            addToSolver(child, solver);
        }
    }
}