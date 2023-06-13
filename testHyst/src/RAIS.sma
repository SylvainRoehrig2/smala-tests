/////////GLOBAL/////////
<global>
</global>

/////////COMPONENT/////////
<component>
</component>

/////////LOCAL/////////
<local>
mobile {
    /*@ruleset hysteresis {exists Binding(waiting_hyst, dragging, waiting_hyst.c.leave)}
    */
}
c {
    /*
    @ruleset correct_position {this == (0, 0, 20) 
                                || (cx==(f.press.x - tr.tx) / sc.sx 
                                    && cy==(f.press.y - tr.ty) / sc.sy 
                                    && c.r ==20 / sc.sx)}
    */
}
</local>