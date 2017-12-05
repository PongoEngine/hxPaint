

package;

import kha.System;

import pongo.Origin;

class Main {
    public static function main() : Void
    {
        System.init({title: "PonGUI", width: 1366, height: 768}, function() {
                var model = null;
                new Origin(model, INIT, Update.update);
        });
    }
}