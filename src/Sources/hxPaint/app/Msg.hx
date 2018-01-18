package hxPaint.app;

enum Msg
{
    SET_PENCIL;
    SET_FILL;
    SET_ERASER;
    SET_COLOR(color :Int);
    FILL_PIXEL(index :Int);
}