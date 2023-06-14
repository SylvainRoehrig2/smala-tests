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
Component root {
  Frame f ("Test Cinq Rectangles", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  FillColor fcRed (255,0,0)
  //@ensures redRec:red_rec_correct
  Rectangle redRec (10, 10, 50, 100, 0, 0)   

  Component blueRects {
    FillColor fcBlue (0,0,255)
    //@ensures blueRec1:blue_rec_correct
    Rectangle blueRec1 (101, 300, 100, 50, 0, 0)

    //@ensures blueRec2:blue_rec_correct
    Rectangle blueRec2 (202, 50, 100, 50, 0, 0)

    //@ensures blueRec3:blue_rec_correct
    Rectangle blueRec3 (250, 150, 100, 50, 0, 0)
  }

  FillColor fcGreen(0,255,0)
  //@ensures green_rec_correct
  Rectangle greenRec (100, 400, 150, 100, 0, 0)    
}
