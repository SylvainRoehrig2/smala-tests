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


_main_
//@file "RAIS.sma"
//@ensures Rectangle:$correct_width && Rectangle:$correct_height 
Component root {
  Frame f ("Test Cinq Rectangles", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex


  FillColor fcRed (255,0,0)
  //@ensures redRec:$red && redRec:$is_at_bottom
  Rectangle redRec (10, 10, 50, 100, 0, 0)   

  //@ensures Rectangle:$blue
  Component blueRects {
    FillColor fcBlue (0,0,255)
    Rectangle blueRec1 (101, 300, 100, 50, 0, 0)
    Rectangle blueRec2 (202, 50, 100, 50, 0, 0)
    Rectangle blueRec3 (250, 150, 100, 50, 0, 0)
  }

  FillColor fcGreen(0,255,0)
  //@ensures greenRec:$is_top_and_green
  Rectangle greenRec (100, 400, 150, 100, 0, 0)  
}
