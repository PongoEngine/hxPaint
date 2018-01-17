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
import kha.input.KeyCode;
import kha.Font;

import jasper.*;

import hxPaint.ui.Box;
import hxPaint.ui.Operation;
import hxPaint.ui.WindowBox;
import hxPaint.ui.LeftPanel;
import hxPaint.ui.RightPanel;
import hxPaint.ui.MainPanel;
import hxPaint.ui.button.ButtonColor;
import hxPaint.ui.button.ButtonPencil;
import hxPaint.ui.button.ButtonFill;
import hxPaint.ui.button.ButtonEraser;
import hxPaint.ui.Pixel;
import hxPaint.ui.Color;

import hxPaint.app.Application;
import hxPaint.app.Model;
import hxPaint.app.Update;

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

        var model :Model = 
            { pencil:
                { isOn: true
                , color1: 0xff000000
                , color2: 0xff000000
                , color3: 0xff000000
                }
            , fill:
                { isOn: false
                , color1: 0xff000000
                , color2: 0xff000000
                , color3: 0xff000000
                }
            , eraser:
                { isOn: false
                }
            , colors:
                [ 0xff000000
                , 0xff808080
                , 0xffC0C0C0
                , 0xffFFFFFF
                , 0xff800000
                , 0xffFF0000
                , 0xff808000
                , 0xffFFFF00
                , 0xff008000
                , 0xff00FF00
                , 0xff008080
                , 0xff00FFFF
                , 0xff000080
                , 0xff0000FF
                , 0xff800080
                , 0xffFF00FF
                ]
            , pixels:
                [for (i in 0...(16*16)) 0xffffffff]
            };

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
        var application = new Application(SET_FILL, model, window, Update.update);
        
        window.addChild(mainPanel);
        window.addChild(new LeftPanel(solver, 0xffaaaaaa)
            .addChild(new ButtonPencil(solver, function() {application.update(SET_PENCIL);}).setOn(true)
                .addChild(new ButtonColor(solver, 0, function() {}))
                .addChild(new ButtonColor(solver, 1, function() {}))
                .addChild(new ButtonColor(solver, 2, function() {})))
            .addChild(new ButtonFill(solver, function() {application.update(SET_FILL);})
                .addChild(new ButtonColor(solver, 0, function() {}))
                .addChild(new ButtonColor(solver, 1, function() {}))
                .addChild(new ButtonColor(solver, 2, function() {})))
            .addChild(new ButtonEraser(solver, function() {application.update(SET_ERASER);})));
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

        application.update(SET_FILL);
        window.solver.updateVariables();
        Box.solve(window);

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
                application.update(SET_PENCIL);
            }
            else if(downKey == KeyCode.W) { //fill
                application.update(SET_FILL);
            }
            else if(downKey == KeyCode.E) { //eraser
                application.update(SET_ERASER);
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
                Box.solve(window);
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