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
  Frame f ("RectRouge", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex
  FillColor fcl (255,0,0)
  Rectangle rleft (0, 0, 600, 600, 0, 0)  
  FillColor fcr (0,0,255)
  Rectangle rright (0, 0, 600, 600, 0, 0)
}
