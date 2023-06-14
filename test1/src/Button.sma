/*
 *	djnn Smala compiler
 *
 *	The copyright holders for the contents of this file are:
 *		Ecole Nationale de l'Aviation Civile, France (2017)
 *	See file "license.terms" for the rights and conditions
 *	defined by copyright holders.
 *
 *
 *	Contributors:
 *		Mathieu Magnaudet <mathieu.magnaudet@enac.fr>
 *
 */
use core
use base
use display
use gui

_define_
Button (Process frame, string label, double x_, double y_) {
  Translation t (x_, y_)

  /*----- interface -----*/
  x aka t.tx
  y aka t.ty
  Spike click
  /*----- interface -----*/

  //@ensures fc == (255,0,0)
  FillColor fc (255, 0, 0)
  /*
  @ruleset colourable {(255,0,0)}
  @ruleset readable {min_opacity : 40,  
                      x_space : 10, y_space : 10}
  @ruleset perceptible {min_width : 50, min_height : 50}
  @requires fc == (255,0,0)                  
  @ensures (colourable && readable && perceptible)
  */
  Rectangle r (0, 0, 100, 70, 10, 10)

  FSM fsm {
    State idle {
      //@ensures fc.r == 255
      255 =: fc.r
    }
    State pressed {
      //@ensures fc.r == 150
      150 =: fc.r
    }
    idle->pressed (r.press)
    pressed->idle (r.release, click)
    pressed->idle (frame.release)
  }

  FillColor w (255, 255, 255)
  Text thisLabel (10, 10, label)

  r.height / 2 =: thisLabel.y
  thisLabel.width + 20 =:> r.width
  thisLabel.width + 20 =:> r.width
}
