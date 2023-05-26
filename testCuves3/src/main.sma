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

// local version
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
  Frame f ("Cuve Test", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  NativeAction na (myFunc, 1)
  Spike caution
  Spike ending

  //@ensures fcl= (255,255,50)
  FillColor fcl (200,255,0)
  /*
  @component:Rectangle ruleset moveable {allow_manual_x_move : false, allow_manual_y_move : true, allow_rotation : false
                                          max_y_move : 600, always_within_frame : true}
  @component:Rectangle ruleset deformable {allow_width_change : false, allow_height_change : true
                                          max_height : 600, min_height : 0}
  @component:Rectangle requires fc == (255,255,50)
  */
  Rectangle rleft (0, 0, 100, 600, 5, 5)  
  //@ensures fcr= (255,255,50)
  FillColor fcr (200,255,0)
  
  Rectangle rright (300, 0, 100, 600, 5, 5)

  Clock cl (17)
  Incr incLeft (1)
  Incr incRight (1)
  TextPrinter log
  FSM fsm {
    State pause{
      Button b (f, "Start", 150, 300)
      0 =: incLeft.state
      0 =: incRight.state
      0 =: rright.y
      0 =: rleft.y
      600 =: rright.height
      600 =: rleft.height
      255 =: fcl.g
      255 =: fcr.g
    }

    //@ensures rleft:moveable && rleft.deformable
    State left{
      
      Button b (f, "Change to Right", 150, 300)
      rleft.height <= 0 -> ending
      cl.tick -> incLeft
      incLeft.state => rleft.y
      600 - incLeft.state => rleft.height
      Modulo modl (0,255)
      (rleft.height/600)*255 => fcl.g
      //600 - incLeft.state => log.input
    }
    //@ensures rright:moveable && rright.deformable
    State right{

      Button b (f, "Change to Left", 150, 300)
      rright.height <= 0 -> ending
      cl.tick -> incRight
      incRight.state => rright.y
      600 - incRight.state => rright.height
      Modulo modl (0,255)
      (rright.height/600)*255 => fcr.g
      //600 - incRight.state => log.input
    }
    State end{
      FillColor _ (255,255,255)
      Text text (120, 50, "One cuve is empty !")
      Button b (f, "Try again", 150, 300)
    }
    pause -> left (pause.b.click)
    left -> right (left.b.click)
    right-> left (right.b.click)
    right -> end (ending)
    left -> end (ending)
    end -> pause (end.b.click)
  }
}
