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

//@file "RAIS.sma"
_main_
Component root {
  Frame f ("Cuve Test 4", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  Spike caution
  Spike ending

  Int original_height (600)

  FillColor fcl (200,255,0)
  Rectangle rleft (0, 0, 100, 600, 5, 5) 

  FillColor fcr (200,255,0)  
  Rectangle rright (300, 0, 100, 600, 5, 5)

  OutlineColor _ (255, 0, 0)
  Line l (0, 400, 400, 400)

  Clock cl (18)
  Incr incLeft (1)
  Incr incRight (1)

  Button b (f, "Start", 150, 300)

  //@ensures (! Rectangle:moveable_x_axis)
  //@ensures Rectangle:moveable_y_axis
  //@ensures b:is_up_to_date
  //@ensures correct_layer
  FSM fsm {
    //@ensures Rectangle:green
    //@ensures Rectangle:moveable_x_axis
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
    //@ensures rleft:change_color
    State left{
      "Change to right" =: b.text
      rleft.height <= original_height/3 -> caution
      cl.tick -> incLeft
      incLeft.state => rleft.y
      original_height - incLeft.state => rleft.height
      (rleft.height/original_height)*255 => fcl.g
    }
    //@ensures rleft:change_color
    State leftCaution{
      "Change to right !!!" =: b.text
      cl.tick -> incLeft
      incLeft.state => rleft.y
      original_height - incLeft.state => rleft.height
      (rleft.height/original_height)*255 => fcl.g
      Warning warn (f, "Cuve presque vide", 0,0) 
      rleft.height <= 0 -> ending
    }
    //@ensures rright:change_color
    State right{
      "Change to left" =: b.text
      rright.height <= original_height/3 -> caution
      cl.tick -> incRight
      incRight.state => rright.y
      original_height - incRight.state => rright.height
      (rright.height/original_height)*255 => fcr.g
    }
    //@ensures rright:change_color
    State rightCaution{
      "Change to left !!!" =: b.text
      cl.tick -> incRight
      incRight.state => rright.y
      original_height - incRight.state => rright.height
      (rright.height/original_height)*255 => fcr.g
      Warning warn (f, "Cuve presque vide", 0,0) 
      rright.height <= 0 -> ending
    }
    //@ensures rright:red || rleft:red
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
