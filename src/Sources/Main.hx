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
        var mainWindow = new Window(0xffaaaaaa, 800, 600);

        var baseStyle = new Style();
        baseStyle.width = CALC(function(variable) {
            return (variable * 1) - 0;
        });
        baseStyle.height = CALC(function(variable) {
            return (variable * 1) - 0;
        });
        var baseBox = new Box(0xffaaaaaa, baseStyle);

        //-----------

        var childStyle = new Style();
        childStyle.width = CALC(function(variable) {
            return (variable*1) - 0;
        });
        childStyle.height = CALC(function(variable) {
            return (variable/4) - 20;
        });
        childStyle.marginTop = PX(20);

        mainWindow.addBox(baseBox
            .addChild(new Box(0xff444444, childStyle))
            .addChild(new Box(0xff222222, childStyle))
            .addChild(new Box(0xffaa44aa, childStyle))
            .addChild(new Box(0xff224444, childStyle)));

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
        for(constraint in child._constraints) {
            solver.addConstraint(constraint);
        }

        var p = child.firstChild;
        while (p != null) {
            var next = p.next;
            addToSolver(p, solver);
            p = next;
        }
    }
}