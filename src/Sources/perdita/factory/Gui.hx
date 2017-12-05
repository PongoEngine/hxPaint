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

import pongo.display.FillSprite;

import perdita.Model;

class Gui
{
    public static function build(origin :Origin<Msg, Model>, scene :Scene<Msg, Model>, model :Model) : Void
    {
        scene.root.addEntity(new FillSprite(0xffff0000, 200, 200)
            .setXY(40, 40));
    }
}