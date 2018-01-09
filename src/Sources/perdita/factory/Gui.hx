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

package perdita.factory;

import pongo.Origin;
import pongo.scene.Scene;
import jasper.*;

import pongo.display.FillSprite;

import perdita.Model;

class Gui
{
    public static function build(origin :Origin<Msg, Model>, scene :Scene<Msg, Model>, model :Model) : Void
    {
        var a_x1 = new Variable("a_x1");
        var a_x2 = new Variable("a_x2");
        var a_y1 = new Variable("a_y1");
        var a_y2 = new Variable("a_y2");

        var b_x1 = new Variable("b_x1");
        var b_x2 = new Variable("b_x2");
        var b_y1 = new Variable("b_y1");
        var b_y2 = new Variable("b_y2");

        var solver = new Solver();

        solver.addConstraint(a_x1 == 50);
        solver.addConstraint(a_x2 == a_x1 + 300);
        solver.addConstraint(a_y1 == 50);
        solver.addConstraint(a_y2 == a_y1 + 200);

        solver.addConstraint(b_x1 == a_x1);
        solver.addConstraint(b_x2 == b_x1 + 200);
        solver.addConstraint(b_y1 == a_y2 + 10);
        solver.addConstraint(b_y2 == b_y1 + 100);

        solver.updateVariables();

        scene.root.addEntity(new FillSprite(0xffff0000, a_x2.m_value - a_x1.m_value, a_y2.m_value - a_y1.m_value)
            .setXY(a_x1.m_value, a_y1.m_value));

        scene.root.addEntity(new FillSprite(0xff00ff00, b_x2.m_value - b_x1.m_value, b_y2.m_value - b_y1.m_value)
            .setXY(b_x1.m_value, b_y1.m_value));
    }
}