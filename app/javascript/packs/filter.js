window.filter = function(filterBy) {
  $(".selected").removeClass("selected");
  $("#filter-"+filterBy).addClass("selected");
  var all = $(".dependency")
  var show = $("." + filterBy)
  all.hide()
  show.show()
}
