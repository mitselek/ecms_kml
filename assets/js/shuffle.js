var shuffle = function(elems) {

    allElems = (function() {
        var ret = [], l = elems.length;
        while (l--) {
            ret[ret.length] = elems[l];
        }
        return ret;
    } )();

    var shuffled = (function() {
        var l = allElems.length, ret = [];
        while (l--) {
            var random = Math.floor(Math.random() * allElems.length);
            var randEl = allElems[random].cloneNode(true);
            allElems.splice(random, 1);
            ret[ret.length] = randEl;
        }
        return ret;
    } )();

    var l = elems.length;
    while (l--) {
        elems[l].parentNode.insertBefore(shuffled[l], elems[l].nextSibling);
        elems[l].parentNode.removeChild(elems[l]);
    }
}
