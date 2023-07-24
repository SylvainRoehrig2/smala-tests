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


// smala lib
//import gui.widgets.Button

_main_
Component root {
  Frame f ("RectRouge", 0, 0, 400, 600)
  Exit ex (0, 1)

  f.close -> ex
  FillColor _ (255,255,255)
  Text txt (250, 10, "idle")
  FillColor fcl (255,0,0)
  Rectangle rleft (0, 0, 200, 200, 0, 0)  
  FSM fsm {
    State idle  {
      "idle" =:txt.text
      0 =: fcl.g
      0 =: fcl.b
    }
    State St1 {
      255 =: fcl.g
      "s1" =:txt.text
    }
    State St2 {
      255 =: fcl.b
      "s2" =:txt.text
    }
    //@prec rleft:$red
    //@post rleft:$yellow
    idle -> St1 (rleft.press)
    //@prec rleft:$yellow
    //@post rleft:$white
    St1 -> St2 (rleft.press)
    //@prec rleft:$white
    //@post rleft:$red
    St2 -> idle (rleft.press)
    
  }
}
