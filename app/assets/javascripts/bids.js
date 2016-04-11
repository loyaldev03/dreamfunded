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
