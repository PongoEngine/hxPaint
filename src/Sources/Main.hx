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
import kha.Assets;

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
        var baseBox = new FillBox("baseBox", 0xffaaaaaa, baseStyle);

        //-----------

        var childStyle = new Style();
        childStyle.width = PERCENT(0.35);
        childStyle.height = PERCENT(0.5);

        mainWindow
            .addChild(new FillBox("red", 0xffff0000, childStyle))
            .addChild(new FillBox("green", 0x5500ff00, childStyle))
            .addChild(new FillBox("blue", 0xff0000ff, childStyle));

        return mainWindow;
    }

    public static function main() : Void
    {
        System.init({title: "Perdita", width: 1366, height: 768}, function() {
            var initialized = false;
            Assets.loadEverything(function() {
                var font = Assets.fonts.Roboto_Black;

                var mainWindow = init();
                var solver = new Solver();

                addToSolver(mainWindow._root, solver);

                solver.updateVariables();
                traceInfo(mainWindow._root);

                System.notifyOnRender(function(framebuffer) {
                    if(!initialized) {
                        framebuffer.g2.font = font;
                        framebuffer.g2.fontSize = 14;
                        initialized = true;
                    }
                    framebuffer.g2.begin(true, 0xffffffff);
                    mainWindow.render(framebuffer);
                    framebuffer.g2.end();
                });
            });
            
        });
    }

    private static function traceInfo(child :Box) : Void
    {
        trace(child.name, child._x.m_value, child._y.m_value, child._width.m_value, child._height.m_value);
        var p = child.firstChild;
        while (p != null) {
            var next = p.next;
            traceInfo(p);
            p = next;
        }
    }

    private static function addToSolver(child :Box, solver :Solver) : Void
    {
        var p = child.firstChild;
        while (p != null) {
            var next = p.next;
            addToSolver(p, solver);
            p = next;
        }

        for(constraint in child._constraints) {
            solver.addConstraint(constraint);
        }
    }
}