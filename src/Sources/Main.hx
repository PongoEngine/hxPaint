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
import perdita.element.Box;
import perdita.element.FillBox;
import perdita.Window;
import perdita.Style;

class Main 
{

    public static function init() : Window
    {
        var mainWindow = new Window(0xffaaaaaa, 800, 600);

        var baseStyle = new Style();
        baseStyle.width = PERCENT(1);
        baseStyle.height = PERCENT(1);
        var baseBox = new FillBox(0xffaaaaaa, baseStyle);

        //-----------

        var childStyle = new Style();
        childStyle.direction = HORIZONTAL;
        childStyle.width = CALC(function(variable) {
            return (variable/4) - 10;
        });
        childStyle.height = PERCENT(0.7);

        //-----------

        var childStyle2 = new Style();
        childStyle2.direction = VERTICAL;
        childStyle2.width = PERCENT(1);
        childStyle2.height = PERCENT(0.25);

        mainWindow.addBox(baseBox
            .addChild(new FillBox(0xff444444, childStyle))
            .addChild(new FillBox(0xff444444, childStyle)
                .addChild(new FillBox(0x11000000, childStyle2))
                .addChild(new FillBox(0x33000000, childStyle2))
                .addChild(new FillBox(0x55000000, childStyle2))
                .addChild(new FillBox(0x77000000, childStyle2)))
            .addChild(new FillBox(0xffaa44aa, childStyle))
            .addChild(new FillBox(0xffaa44aa, childStyle)
                .addChild(new FillBox(0x11000000, childStyle2))
                .addChild(new FillBox(0x33000000, childStyle2))
                .addChild(new FillBox(0x55000000, childStyle2))
                .addChild(new FillBox(0x77000000, childStyle2))));

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
                mainWindow.render(framebuffer);
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