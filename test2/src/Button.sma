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

import Drag 
_define_
Button (Process frame, string label, double x_, double y_) {
  Translation t (x_, y_)

  /*----- interface -----*/
  x aka t.tx
  y aka t.ty
  Spike click
  /*----- interface -----*/



  FillColor fc (50, 150, 50)
  Rectangle r (0, 0, 100, 70, 10, 10)

            
  FSM fsm {
    State idle {

      FillColor w (255, 255, 255)
      Text thisLabel (10, 10, label)

      r.height / 2 =: thisLabel.y
      thisLabel.width + 20 =:> r.width
      thisLabel.width + 20 =:> r.width
    }
    State pressed {
      50 =: fc.g
      Component draggableRectangle {
        
            Homography dragTransform
               
            //@ensures (fc2 == (255,255,255))
            FillColor fc2 (255,255,255)
            /*
            @requires (fc2 == (255.255.255))
            @ruleset colourable {(255,255,255)}
            @ruleset valid_content {Rectangle, (_,_,100,70,_,_)}
            @ensures (colourable && valid_content)
            */
            Rectangle r2 (100, 100, 100, 70, 10, 10)
            Translation _ (0,150)
            
            Drag drag (r2, dragTransform, frame)
      }
    }
    idle->pressed (r.press, click)
  }

}
