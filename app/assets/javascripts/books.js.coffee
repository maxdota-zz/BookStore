# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("div.star-rating > s, div.star-rating-rtl > s").on "click", (e) ->
    numStars = $(e.target).parentsUntil("div").length + 1
    alert numStars + ((if numStars is 1 then " star" else " stars!"))
