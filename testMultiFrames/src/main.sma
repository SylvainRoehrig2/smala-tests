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
  Frame f1 ("Frame1", 0, 0, 400, 600)
  Exit ex (0, 1)
  f1.close -> ex
  FillColor _ (255,255,255)
  Rectangle r1 (0, 0, 100, 600, 5, 5)  
  Incr i (10)
  TextPrinter log1
  1 =: DrawingRefreshManager.auto_refresh

  f1.release->DrawingRefreshManager.draw_sync

  Frame f2 ("Frame2", 600, 0, 400, 600)
  f2.close -> ex
  Rectangle r2 (0, 0, 100, 600, 5, 5)  
  TextPrinter log2
  Button b2 (f2,"Test",0,0)
  b2.click -> i
  i.state => r1.x
  i.state => r2.x
  r1.x => log1.input
  r2.x => log2.input
  1 =: DrawingRefreshManager.auto_refresh
  f2.press->DrawingRefreshManager.draw_sync

  
}
