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
  Frame f ("Test Change Color", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  Spike caution
  Spike ending

  FillColor _ (255,255,255)
  Text tx (100,100,"X_Coord")
  Text ty (100,120,"Y_Coord")
  Text red (100,200,"R")
  Text gre (100,220,"G")
  Text blu (100,240,"B")

  OutlineColor _ (255, 255, 255)
  FillColor fc (0,255,0)
  //@requires outline_color_existence
  //@ensures rec:white_outline
  Rectangle rec (100, 130, 100, 50, 5, 5)  
  
  f.height / 2 - rec.height =: rec.x
  f.width / 2 - rec.width =: rec.x

  Min min (0,0)
  Max max (0,0)
  mouseTracking = 1
  f.move.x=> tx.text
  f.move.y=> ty.text
  //@ensures blue_color_updates && rec:blue_correct_color
  (f.move.x / f.width)*255 => fc.b
  //@ensures red_color_updates && rec:red_correct_color
  (f.move.y / f.height)*255 => fc.r
  fc.b => min.left
  fc.r => min.right
  fc.b => max.left
  fc.r => max.right
  //@ensures green_color_updates && rec:green_correct_color
  255 - (max.result - min.result) => fc.g
  fc.r => red.text
  fc.b => blu.text
  fc.g => gre.text
}
