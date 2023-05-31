use core
use base
use display
use gui

_define_
Warning (Process frame, string label, double x_, double y_) {
  Translation t (x_, y_)
  /*----- interface -----*/
  x aka t.tx
  y aka t.ty
  /*----- interface -----*/

  Clock cl (2)
  Incr inc (1)
  Spike gotored
  Spike gotowhite
  FillColor fc (255, 255, 255)
  TextAnchor _ (1)
  FontSize fs (0, 18) 
  Text warning (0, 0, "Attention")
  Text thisLabel (0, 20, label)
  frame.height / 2 -100 =:> thisLabel.y
  frame.width /2 =:> thisLabel.x
  thisLabel.y - 30 =:> warning.y
  thisLabel.x =:> warning.x

  TextPrinter log
  FSM fsm{
    State white{
        Modulo mod (0,256)
        cl.tick -> inc
        inc.state => mod.left
        //mod.result => log.input
        255 - mod.result <= 0 -> gotored
        255 - mod.result => fc.g
        255 - mod.result => fc.b
    }
    State red{
        Modulo mod (0,256)
        cl.tick -> inc
        inc.state => mod.left
        //mod.result => log.input
        mod.result >= 255-> gotowhite
        mod.result => fc.g
        mod.result => fc.b
    }
    white -> red (gotored)
    red -> white (gotowhite)
  }
}
