  String.prototype.replaceAll = function(search, replacement) {
      var target = this;
      return target.split(search).join(replacement);
  };
  function addCommas(nStr) {
    nStr = nStr.replaceAll(',', '');
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
  }

$(document).ready(function(){

    $(".view-counter-offer").click(function (e) {
        console.log('click')
        e.preventDefault();

        $header = $(this);
        //getting the next element

        $content = $('.counter-offer-content')
        //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
        $content.slideToggle(500, function () {
            //execute this after slideToggle is done
            //change text of header based on visibility of content div
            $header.val(function () {
                //change text based on condition
                return $content.is(":visible") ? "HIDE OFFER" : "VIEW OFFER";
            });
        });

    });
})
