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
import kha.Font;
import jasper.*;
import hxPaint.Box;
import hxPaint.Operation;
import hxPaint.WindowBox;
import hxPaint.LeftPanel;
import hxPaint.RightPanel;
import hxPaint.MainPanel;
import hxPaint.button.ButtonColor;
import hxPaint.button.ButtonPencil;
import hxPaint.button.ButtonFill;
import hxPaint.button.ButtonEraser;
import hxPaint.Pixel;
import hxPaint.Color;
import kha.input.KeyCode;

class Main 
{
    public static var color :Int = 0xff000000;
    public static var font :Font = null;
    public static var fontSize :Int = 18;
    public static var operation :Operation = PENCIL;
    public static var pixels :Array<Pixel> = [];

    public static function main() : Void
    {
        System.init({title: "jasper-example", width: 1366, height: 768}, function() {
            Assets.loadEverything(onLoaded);
        });
    }

    private static function onLoaded() : Void
    {
        font = Assets.fonts.Roboto_Black;
        var width = System.windowWidth();
        var height = System.windowHeight();
        var solver = new Solver();
        var rowLength = 32;
        var mainPanel = new MainPanel(solver, 0xffffffff);
        for(i in 0...rowLength*rowLength) {
            var x = i%rowLength;
            var y = Math.floor(i/rowLength);
            var pixel = new Pixel(solver, x, y, rowLength);
            pixels[y*rowLength + x] = pixel;
            mainPanel.addChild(pixel);
        }

        var window = new WindowBox(0xff444444, width, height, solver);
        window.addChild(mainPanel);
        window.addChild(new LeftPanel(solver, 0xffaaaaaa)
            .addChild(new ButtonPencil(solver, function() {Main.operation = PENCIL;})
                .addChild(new ButtonColor(solver, 0, function() {}))
                .addChild(new ButtonColor(solver, 1, function() {}))
                .addChild(new ButtonColor(solver, 2, function() {})))
            .addChild(new ButtonFill(solver, function() {Main.operation = FILL;})
                .addChild(new ButtonColor(solver, 0, function() {}))
                .addChild(new ButtonColor(solver, 1, function() {}))
                .addChild(new ButtonColor(solver, 2, function() {})))
            .addChild(new ButtonEraser(solver, function() {Main.operation = ERASER;})));
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

        window.solver.updateVariables();
        Box.solved(window);

        var initialized = false;
        System.notifyOnRender(function(framebuffer) {
            if(!initialized) {
                framebuffer.g2.font = font;
                framebuffer.g2.fontSize = fontSize;
                initialized = true;
            }
            framebuffer.g2.begin(0xffffffff);
            Box.render(window, framebuffer);
            framebuffer.g2.end();
        });

        initMouse(window, mainPanel);

        kha.input.Keyboard.get().notify(function(downKey :KeyCode) {
            if(downKey == KeyCode.Q) { //pencil
                Main.operation = PENCIL;
            }
            else if(downKey == KeyCode.W) { //fill
                Main.operation = FILL;
            }
            else if(downKey == KeyCode.E) { //eraser
                Main.operation = ERASER;
            }
        }, function(upKey :KeyCode) {

        }, function(str :String) {

        });
    }

    public static function initMouse(window :WindowBox, mainPanel :MainPanel) : Void
    {
        kha.input.Mouse.get().notify(function(b,x,y) {
            if(b==1) {
                window.solver.suggestValue(window.width, x);
                window.solver.suggestValue(window.height, y);
                window.solver.updateVariables();
                Box.solved(window);
            }
            else {
                Box.hitTest(window,x,y, DOWN);
            }
        }, function(b,x,y) {
            Box.hitTest(window,x,y, UP);
            mainPanel.onUp(-1,-1);
        }, function(x,y,cX,cY) {
            Box.hitTest(window,x,y, MOVE);
        }, function(c) {
        });
    }
}