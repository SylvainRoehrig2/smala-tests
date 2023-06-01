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
  Frame f ("Cuve Test 4", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  NativeAction na (myFunc, 1)
  Spike caution
  Spike ending

  Int original_height (600)

  //@ensures fcl= (200,255,50)
  FillColor fcl (200,255,0)
  /*
  @component:Rectangle ruleset moveable {allow_manual_y_move : false, allow_y_move : true, allow_rotation : false
                                          max_y_move : unlimited}
  @component:Rectangle ruleset deformable {allow_width_change : false, allow_height_change : true
                                          max_height : unlimited, min_height : 0}
  @component:Rectangle ruleset scalable {update_on_frame_refresh : false, frame_height_dependent : true}
  @component:Rectangle ruleset always_visible {always_top_layer : false, always_within_frame : true, can_be_partially_in_frame : false}
  @component:Rectangle requires fc == (255,255,50)
  */
  Rectangle rleft (0, 0, 100, 600, 5, 5)  
  //@ensures fcr= (200,255,50)
  FillColor fcr (200,255,0)
  
  Rectangle rright (300, 0, 100, 600, 5, 5)

  //@ensures _ = (255,0,0)
  OutlineColor _ (255, 0, 0)
  //@requires _ = (255,0,0)
  Line l (0, 400, 400, 400)

  //@ruleset scalable {update_on_frame_refresh : false, frame_height_dependent : true}
  Clock cl (18)

  //@component:Incr ruleset scalable {update_on_frame_refresh : false, frame_height_dependent : true}
  Incr incLeft (1)
  Incr incRight (1)

  /*
  @ruleset moveable {allow_manual_y_move : false, allow_y_move : true, allow_manual_x_move : false, allow_x_move : true, 
                      allow_rotation : false}
  @ruleset clickable {isClickable : true, has_signal_on : release}
  @ruleset scalable {update_on_frame_refresh : false, frame_height_dependent : true, frame_width_dependent : true
  */
  Button b (f, "Start", 150, 300)

  FSM fsm {
    //@ensures rright.y == 0 && rright.x == f.width-100 && original_height == f.height && fcl.g == 255 && fcr.g == 255
    //@ensures l.y1 == f.height - 200 && l.y2 == f.height -200 && l.x2 == f.width
    //@ensures b.x == (f.width / 2)-50 && b.y == (f.height /2)-50 && cl.period == 5000/f.height
    //@ensures rleft:scalable && rright:scalable && rleft:always_visible && rright:always_visible
    State start{
      "Start" =: b.text
      0 =: incLeft.state
      0 =: incRight.state
      0 =: rright.y
      0 =: rleft.y
      f.width -100 =: rright.x
      f.height =: rright.height
      f.height =: rleft.height
      f.height =: original_height
      f.height - original_height/3 =: l.y1
      f.height - original_height/3 =: l.y2
      f.width =: l.x2
      (f.height / 2) -50 =: b.y
      (f.width / 2) -50 =: b.x
      255 =: fcl.g
      255 =: fcr.g
      5000/f.height =: cl.period
    }

    //@ensures rleft:moveable && rleft.deformable && rleft:scalable && rleft:always_visible
    State left{
      "Change to right" =: b.text
      rleft.height <= original_height/3 -> caution
      cl.tick -> incLeft
      incLeft.state => rleft.y
      original_height - incLeft.state => rleft.height
      (rleft.height/original_height)*255 => fcl.g
    }
    //@ensures rleft:moveable && rlfet:deformable && rleft:scalable && rleft:always_visible
    State leftCaution{
      "Change to right !!!" =: b.text
      cl.tick -> incLeft
      incLeft.state => rleft.y
      original_height - incLeft.state => rleft.height
      (rleft.height/original_height)*255 => fcl.g
      /*
      @component:Warning ruleset moveable {allow_manual_y_move : false, allow_y_move : true, allow_manual_x_move : false, allow_x_move : true, 
                          allow_rotation : false, always_within_frame : true}
      @component:Warning ruleset scalable {update_on_frame_refresh : false, frame_height_dependent : true, frame_width_dependent : true, always_within_frame : true}
      @component:Warning ruleset readable {min_opacity : 100}
      @component:Warning ruleset perceptible {min_fontsize : 18, layer : top, percentage : 100}
      */
      Warning warn (f, "Cuve presque vide", 0,0) 
      rleft.height <= 0 -> ending
    }
    //@ensures rright:moveable && rright.deformable && rright:scalable && rright:always_visible
    State right{
      "Change to left" =: b.text
      rright.height <= original_height/3 -> caution
      cl.tick -> incRight
      incRight.state => rright.y
      original_height - incRight.state => rright.height
      (rright.height/original_height)*255 => fcr.g
    }
    //@ensures rright:moveable && rright.deformable && rright:scalable && rright:always_visible
    State rightCaution{
      "Change to left !!!" =: b.text
      cl.tick -> incRight
      incRight.state => rright.y
      original_height - incRight.state => rright.height
      (rright.height/original_height)*255 => fcr.g
      Warning warn (f, "Cuve presque vide", 0,0) 
      rright.height <= 0 -> ending
    }
    State end{
      FillColor _ (255,255,255)
      Text text (120, 50, "One cuve is empty !")
      "Try again" =: b.text
    }
    start -> left (b.click)
    left -> right (b.click)
    right-> left (b.click)
    leftCaution -> right (b.click)
    rightCaution-> left (b.click)
    right -> rightCaution (caution)
    left -> leftCaution (caution)
    rightCaution -> end (ending)
    leftCaution -> end (ending)
    end -> start (b.click)
  }
}
