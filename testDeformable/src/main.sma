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

import Button
// smala lib
//import gui.widgets.Button

_native_code_
%{
#include <iostream>
%}

_action_
myFunc (Process c) 
%{
  std::cout << ("Button clicked") << std::endl;
%}


_main_
Component root {
  Frame f ("RectRouge", 0, 0, 600, 600)
  Exit ex (0, 1)
  f.close -> ex

  //@global ruleset red {color == (255,0,0)}
  //@global ruleset green {color == (0,255,0)}
  Spike incremOnly
  Spike decremOnly
  Spike allButtonSpike

  FillColor fc (0,0,0)
  //@component:Rectangle ruleset correct_width {width > 100 && width < 500}
  Rectangle r (0, 0, 300, 150, 0, 0)  
  FSM fsm {
    //@ensures r:green
    State idle {
      0 =: fc.r
      255 =: fc.g
    }
    //@ensures r:red
    State pressed {
      0 =: fc.g
      255 =: fc.r
    }
    idle->pressed (r.press)
    pressed->idle (r.release)
    pressed->idle (f.release)
  }

  //@global ruleset dynamic_width {exists (<process_id|expression> =: width)}
  //@ensures r:dynamic_width
  AssignmentSequence incrementWidth (1) {
    r.width + 50 =: r.width
  } 
  AssignmentSequence decrementWidth (1) {
    r.width - 50 =: r.width
  }
 
  //@ensures r:correct_width
  FSM buttons{
    State allButtons {
      r.width <= 100 -> incremOnly
      r.width >= 500 -> decremOnly
      Button bincr (f, "Incrémenter", 0,300)
      Button bdecr(f, "Décrémenter", 300,300)
      bincr.click -> incrementWidth
      bdecr.click -> decrementWidth
    }
    State incrOnly {
      Button bincr (f, "Incrémenter", 0,300)
      bincr.click -> incrementWidth
      r.width > 100 -> allButtonSpike
    }
    State decrOnly {
      Button bdecr(f, "Décrémenter", 300,300)
      bdecr.click -> decrementWidth
      r.width < 500 -> allButtonSpike
    }
    allButtons -> incrOnly (incremOnly)
    allButtons -> decrOnly (decremOnly)
    incrOnly -> allButtons (allButtonSpike)
    decrOnly -> allButtons (allButtonSpike)
  }
}
