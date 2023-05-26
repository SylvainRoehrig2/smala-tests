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
import Warning

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
  Frame f ("Cuve Test 3", 0, 0, 400, 600)
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

  Int original_height (600)
  //@ensures _ = (255,0,0)
  OutlineColor _ (255, 0, 0)
  //@requires _ = (255,0,0)
  Line l (0, 400, 400, 400)
  Clock cl (18)
  Incr incLeft (1)
  Incr incRight (1)
  TextPrinter log

  FSM fsm {
    //@ensures rright.y == 0 && rright.x == f.width-100 && rright.height == f.height
    //@ensures rleft.height == f.height && original_height == f.height && fcl.g == 255 && fcr.g == 255
    State start{
      Button b (f, "Start", 150, 300)
      0 =: incLeft.state
      0 =: incRight.state
      0 =: rright.y
      0 =: rleft.y
      f.width -100 =: rright.x
      f.height =: rright.height
      f.height =: rleft.height
      f.height =: original_height
      255 =: fcl.g
      255 =: fcr.g
      5000/f.height =: cl.period
    }

    //@ensures rleft:moveable && rleft.deformable
    State left{
      
      Button b (f, "Change to Right", 150, 300)
      rleft.height <= 200 -> caution
      cl.tick -> incLeft
      incLeft.state => rleft.y
      original_height - incLeft.state => rleft.height
      Modulo modl (0,255)
      (rleft.height/original_height)*255 => fcl.g
      //600 - incLeft.state => log.input
    }
    //@ensures rleft:moveable && rlfet:deformable && fcl.g == 50
    State leftCaution{
      Button b (f, "Change to Right !", 150, 300)
      cl.tick -> incLeft
      incLeft.state => rleft.y
      600 - incLeft.state => rleft.height
      50 =: fcl.g 
      //600 - incLeft.state => log.input
      rleft.height <= 0 -> ending
    }
    //@ensures rright:moveable && rright.deformable
    State right{

      Button b (f, "Change to Left", 150, 300)
      rright.height <= 200 -> caution
      cl.tick -> incRight
      incRight.state => rright.y
      original_height - incRight.state => rright.height
      Modulo modl (0,255)
      (rright.height/original_height)*255 => fcr.g
      //600 - incRight.state => log.input
    }
    //@ensures rright:moveable && rright.deformable && fcr.g == 50
    State rightCaution{
      Button b (f, "Change to Left !", 150, 300)
      cl.tick -> incRight
      incRight.state => rright.y
      600 - incRight.state => rright.height
      50 =: fcr.g 
      rright.height <= 0 -> ending
    }
    State end{
      FillColor _ (255,255,255)
      Text text (120, 50, "One cuve is empty !")
      Button b (f, "Try again", 150, 300)
    }
    start -> left (start.b.click)
    left -> right (left.b.click)
    right-> left (right.b.click)
    leftCaution -> right (leftCaution.b.click)
    rightCaution-> left (rightCaution.b.click)
    right -> rightCaution (caution)
    left -> leftCaution (caution)
    rightCaution -> end (ending)
    leftCaution -> end (ending)
    end -> start (end.b.click)
  }

  /* behavior */
  Switch sw (deactivated) {
    Component activated {
      Warning warn (f, "Cuve presque vide", 0,0) 
    }
    Component deactivated
  }
  (rright.height <= 200 || rleft.height <= 200) && (rleft.height > 1 && rright.height > 1 ) ? "activated" : "deactivated" => sw.state
  
}
