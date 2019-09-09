If you want to run Elm locally instead of on `mathoutreach.rocks`,
you'll need to install the GraphicSVG library and include it in the file.

1. Install [Elm](https://guide.elm-lang.org/install.html)
2. Make a directory and go inside of it: `mkdir elm_proj` then `cd elm_proj`
3. Now inside the directory, initialize the project `elm init` and reply with `y` to the prompt
4. Install the GraphicSVG library `elm install MacCASOutreach/graphicsvg` and reply with `y` to the prompt
5. Create the file you'll be editing inside the `src/` directory
6. Add the following lines to the top of your file:

```elm
module App exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
```

You'l probably also need these rendering functions at the bottom:

```elm
main = gameApp Tick {model = init, view = view, update = update, title = "Game Slot"}
view model = collage 192 128 (myShapes model)
```

7. Allow the file to be continuous compiled and updated using Elm Reactor `cd src` and `elm reactor`

(Tested on Windows 10)
