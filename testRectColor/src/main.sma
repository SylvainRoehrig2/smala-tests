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

//@file "RAIS.sma"
_main_
Component root {
  Frame f ("Cuve Test 4", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  Component greenRectangle {
    FillColor fcGreen (0,0,0)
    Rectangle rec1 (0, 0, 100, 200, 5, 5)  
  }

  FillColor fcOrange (0,0,0)
  Rectangle rec2 (150, 0, 100, 200, 5, 5)  

  FillColor fcRed (0,0,0)
  Rectangle rec3 (300, 0, 100, 200, 5, 5)  

  Button b1 (f, "Prendre rec3", 0, 300)
  Button b2 (f, "Prendre rec1", 150, 300)
  Button b3 (f, "Prendre rec2", 300, 300)
  Button b4 (f, "Reset", 150, 500)

  Switch sw (idle) {
      Component idle {
        //@ensures greenRectangle.rec1:$green
        #0F9A0F =: greenRectangle.fcGreen.value
        //@ensures rec3:$red
        #9A0F0F =: fcRed.value
        //@ensures rec2:$orange
        #9A6A0F =: fcOrange.value
      }
      Component rec1Change {
        //@ensures greenRectangle.rec1:$same_color_as_rec3
        fcRed.value =: greenRectangle.fcGreen.value
      }
      Component rec2Change {
        //@ensures rec2:$same_color_as_rec1
        greenRectangle.fcGreen.value =: fcOrange.value
      }
      Component rec3Change {
        //@ensures rec3:$same_color_as_rec2
        fcOrange.value =: fcRed.value
      }
    }
  FSM fsm {
    State idle
    State rec1Change
    State rec2Change
    State rec3Change
    idle ->rec1Change (b1.click)
    idle->rec2Change (b2.click)
    idle->rec3Change (b3.click)
    rec1Change->rec2Change (b2.click)
    rec1Change->rec3Change (b3.click)
    rec2Change ->rec1Change (b1.click)
    rec2Change->rec3Change (b3.click)
    rec3Change ->rec1Change (b1.click)
    rec3Change->rec2Change (b2.click)
    rec1Change ->idle (b4.click)
    rec2Change->idle (b4.click)
    rec3Change->idle (b4.click)
  }
  fsm.state => sw.state // don't forget to connect FSM and Switch
}
