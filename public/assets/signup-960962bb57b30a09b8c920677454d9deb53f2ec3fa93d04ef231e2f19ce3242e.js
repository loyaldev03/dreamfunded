function onOff() {
    var boxeschecked = 0;
    for (var i = 1; i<= 5; i++) {
        if(document.getElementById("box" + i).checked == true){
        	boxeschecked ++;
        }
    }
    if (boxeschecked == 0) {document.getElementById("submit-button").disabled= true;}
    if (boxeschecked != 0) {document.getElementById("submit-button").disabled= false;}
}
