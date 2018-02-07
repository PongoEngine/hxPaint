/*
 * Copyright (c) 2018 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package;

import kha.System;
import kha.Scheduler;

import hxPaint.Paint;
import hxPaint.element.LeftColumn;
import hxPaint.element.palette.Pallete;
import hxPaint.element.palette.ColorOption;
import hxPaint.element.palette.PaletteToggle;
import hxPaint.element.canvas.Canvas;
import hxPaint.element.canvas.Pixels;
import hxPaint.element.ToolButton;
import hxPaint.element.header.Header;
import hxPaint.element.header.HeaderButton;
import hxPaint.element.header.HeaderList;
import hxPaint.element.header.HeaderListItem;
import hxPaint.element.Body;

class Main 
{
    public static function main() : Void
    {
        System.init({title: "hxPaint", width: 1366, height: 768}, function() {
            kha.Assets.loadEverything(function() {

                var toggle :PaletteToggle;
                var paint = new Paint(kha.System.windowWidth(), kha.System.windowHeight());
                var canvas = new Canvas(paint);
                paint.window
                    .addChild(new Body(paint)
                        .addChild(new LeftColumn(paint)
                            .addChild(new ToolButton(paint, "PENCIL", PENCIL)) //pencil
                            .addChild(new ToolButton(paint, "FILL", FILL)) //fill
                            .addChild(new ToolButton(paint, "LINE", LINE)) //line
                            .addChild(new ToolButton(paint, "CIRCLE", CIRCLE)) //circle
                            .addChild(new ToolButton(paint, "ERASER", ERASER)) //eraser
                            .addChild(toggle = new PaletteToggle(paint)))
                        .addChild(canvas)
                        .addChild(new Pallete(paint)
                            .addChild(new ColorOption(paint, Pixels.BLACK))
                            .addChild(new ColorOption(paint, Pixels.BLUE))
                            .addChild(new ColorOption(paint, Pixels.BROWN))
                            .addChild(new ColorOption(paint, Pixels.GREEN))
                            .addChild(new ColorOption(paint, Pixels.ORANGE))
                            .addChild(new ColorOption(paint, Pixels.RED))
                            .addChild(new ColorOption(paint, Pixels.RED_ORANGE))
                            .addChild(new ColorOption(paint, Pixels.SKY_BLUE))
                            .addChild(new ColorOption(paint, Pixels.VIOLET))
                            .addChild(new ColorOption(paint, Pixels.WHITE))
                            .addChild(new ColorOption(paint, Pixels.YELLOW))
                            .addChild(new ColorOption(paint, Pixels.YELLOW_GREEN))))

                    .addChild(new Header(paint)
                        .addChild(new HeaderButton(paint, "File")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "OPTION1"))
                                .addChild(new HeaderListItem(paint, "OPTION2"))))

                        .addChild(new HeaderButton(paint, "Edit")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "OPTION_A"))))

                        .addChild(new HeaderButton(paint, "Help")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "OPTION_B"))
                                .addChild(new HeaderListItem(paint, "OPTION_C"))
                                .addChild(new HeaderListItem(paint, "OPTION_D")))));

                paint.initLayout();
                toggle.turnOn();

                var hasInit = false;
                System.notifyOnRender(function(framebuffer) {
                    if(!hasInit) {
                        framebuffer.g2.font = kha.Assets.fonts.Roboto_Black;
                        framebuffer.g2.fontSize = 18;
                        hasInit = true;
                    }

                    framebuffer.g2.begin(0xffffffff);
                    paint.render(kha.System.windowWidth(), kha.System.windowHeight(), framebuffer);
                    framebuffer.g2.end();
                });

                Scheduler.addTimeTask(function() {
                    paint.update(frameTime);
                }, 0, 1 / 60);
            });
        });
    }

    private static inline var frameTime = 1/60;

    
}