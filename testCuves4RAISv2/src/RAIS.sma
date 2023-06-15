/////////GLOBAL/////////
<global>
/*
@ruleset red {color.r == 255}
@ruleset green {color.g == 255}
@ruleset moveable_x_axis {exists Assignement(x)}
@ruleset correct_layer {true}
@ruleset is_up_to_date {true}
*/
</global>

/////////COMPONENT/////////
<component>
Rectangle {
    /*
    @ruleset red {color.r == 200 && color.g <= 0 }
    @ruleset moveable_y_axis {exists Binding(y) || exists Assignement(y)}
    @ruleset correct_layer {layer == Bottom}
    @ruleset change_color {exists Binding(color.g) && color.g==(this.height/original_height)*255}
    */
}
Warning {
    /*
    @ruleset correct_layer {layer == Top}
    */
}
</component>

/////////LOCAL/////////
<local>
b {
    //@ruleset is_up_to_date {exists Assignement(text)}
    //@ruleset text_is_start {this.text == "Start"}
}
text {
    //@ruleset correct_layer {layer == Before(warn)}
}

</local>