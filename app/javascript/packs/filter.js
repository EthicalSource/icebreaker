window.filter = function(filterBy) {
  var all = $(".dependency")
  var show = $("." + filterBy)
  all.hide()
  show.show()
}
