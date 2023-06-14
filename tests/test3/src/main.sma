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

_main_
Component root {
  Frame f ("my frame", 0, 0, 400, 600)
  Exit ex (0, 1)
  f.close -> ex

  FillColor fc (150,50,50)
  /*
  @ruleset valid_content {Rectangle, (f.width/2 - f.width/8, f.height/2 - f.height/8, f.width/4, f.height/4)}
  
  */
  Rectangle r (f.width/2 - f.width/8, f.height/2 - f.height/8, f.width/4, f.height/4)
  Switch sw (greater) {
    Component true {      
      50 =: fc.r    
      250 =: fc.b 
    }
    Component false {   
      150 =: fc.r     
      50 =: fc.b
    }
  }
  (f.move.x < r.x + f.width/4 && f.move.x > r.x && f.move.y <  r.y +f.height/4 && f.move.y > r.y) ? "true" : "false" => sw.state

  FSM fsm {
        State idle {
          f.width/2 - f.width/8 =: r.x
          f.height/2 - f.height/8 =: r.y
          f.width/4 =: r.width
          f.height/4 =: r.height
        }
        State pressed {
          f.width/2 - f.width/8 =: r.x
          f.height/2 - f.height/8 =: r.y
          f.width/4 =: r.width
          f.height/4 =: r.height
        }
        idle->pressed (f.refreshed)
        pressed->idle (f.refreshed)
  }

  Scaling scaling (1,1,0,0)
  Double zoom (1)
  zoom =:> scaling.sx, scaling.sy
  f.width /2 =:> scaling.cx
  f.height /2 =:> scaling.cy

  Pow p (1.01, 0)
  f.wheel.dy =:> p.exponent

  AssignmentSequence seq (0) {
    // apply new zoom
    zoom * p.result =: zoom
  }
  p.result -> seq


  mouseTracking = 1
}
