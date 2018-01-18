package hxPaint.app;

class Update
{
    public static function update(msg :Msg, model :Model) : Model
    {
        switch msg {
            case SET_PENCIL: {
                model.pencil.isOn = true;
                model.fill.isOn = false;
                model.eraser.isOn = false;
            }
            case SET_FILL: {
                model.pencil.isOn = false;
                model.fill.isOn = true;
                model.eraser.isOn = false;
            }
            case SET_ERASER: {
                model.pencil.isOn = false;
                model.fill.isOn = false;
                model.eraser.isOn = true;
            }
            case SET_COLOR(color): {
                model.color = color;
            }
            case FILL_PIXEL(index): {
                model.pixels[index] = model.color;
            }
        }
        return model;
    }
}