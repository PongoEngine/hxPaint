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
import hxPaint.element.Pallete;
import hxPaint.element.canvas.Canvas;
import hxPaint.element.canvas.Pixels;
import hxPaint.element.Button;
import hxPaint.element.ColorButton;
import hxPaint.element.SpecialButton;
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
                var paint = new Paint(kha.System.windowWidth(), kha.System.windowHeight());
                var canvas = new Canvas(paint);
                var palette :Pallete = cast new Pallete(paint)
                    .addChild(new ColorButton(paint, Pixels.BLACK)) //Black #000000
                    .addChild(new ColorButton(paint, Pixels.BLUE)) //Blue #0066FF
                    .addChild(new ColorButton(paint, Pixels.BROWN)) //Brown #AF593E
                    .addChild(new ColorButton(paint, Pixels.GREEN)) //Green #01A368
                    .addChild(new ColorButton(paint, Pixels.ORANGE)) //Orange #FF861F
                    .addChild(new ColorButton(paint, Pixels.RED)) //Red #ED0A3F
                    .addChild(new ColorButton(paint, Pixels.RED_ORANGE)) //Red Orange #FF3F34
                    .addChild(new ColorButton(paint, Pixels.SKY_BLUE)) //Sky Blue #76D7EA
                    .addChild(new ColorButton(paint, Pixels.VIOLET)) //Violet (Purple) #8359A3
                    .addChild(new ColorButton(paint, Pixels.WHITE)) //White #FFFFFF
                    .addChild(new ColorButton(paint, Pixels.YELLOW)) //Yellow #FBE870
                    .addChild(new ColorButton(paint, Pixels.YELLOW_GREEN)); //Yellow Green #C5E17A

                var fnButtonOff = function() {
                    paint.model.operation = INVALID;
                }

                paint.window
                    .addChild(new Body(paint)
                        .addChild(new LeftColumn(paint)
                            .addChild(new Button(paint, "PENCIL", function() {paint.model.operation = PENCIL;}, fnButtonOff)) //pencil
                            .addChild(new Button(paint, "FILL", function() {paint.model.operation = FILL;}, fnButtonOff)) //fill
                            .addChild(new Button(paint, "LINE", function() {paint.model.operation = LINE;}, fnButtonOff)) //line
                            .addChild(new Button(paint, "CIRCLE", function() {paint.model.operation = CIRCLE;}, fnButtonOff)) //circle
                            .addChild(new Button(paint, "ERASER", function() {paint.model.operation = ERASER;}, fnButtonOff)) //eraser
                            .addChild(new SpecialButton(paint, function() {palette.open();}, function(){palette.close();})))
                        .addChild(canvas)
                        .addChild(palette))

                    .addChild(new Header(paint)
                        .addChild(new HeaderButton(paint, "File")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "NEW"))
                                .addChild(new HeaderListItem(paint, "SAVE"))))

                        .addChild(new HeaderButton(paint, "Edit")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "UNDO - (cmd-z)"))))

                        .addChild(new HeaderButton(paint, "Help")
                            .addChild(new HeaderList(paint)
                                .addChild(new HeaderListItem(paint, "DOCUMENTS"))
                                .addChild(new HeaderListItem(paint, "CYOA"))
                                .addChild(new HeaderListItem(paint, "ABOUT khaPOW")))));

                paint.initLayout();

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