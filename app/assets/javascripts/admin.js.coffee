# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require metisMenu
#//= require raphael.min
#//= require jquery.dataTables
#//= require dataTables.bootstrap

$ ->
  $('.dataTable').dataTable
    'iDisplayLength': 25

$ ->
  $("#side-menu").metisMenu()
  return

#Loads the correct sidebar on window load,
#collapses the sidebar on window resize.
# Sets the min-height of #page-wrapper to window size
$ ->
  $(window).bind "load resize", ->
    topOffset = 50
    width = (if (@window.innerWidth > 0) then @window.innerWidth else @screen.width)
    if width < 768
      $("div.navbar-collapse").addClass "collapse"
      topOffset = 100 # 2-row-menu
    else
      $("div.navbar-collapse").removeClass "collapse"
    height = (if (@window.innerHeight > 0) then @window.innerHeight else @screen.height)
    height = height - topOffset
    height = 1  if height < 1
    $("#page-wrapper").css "min-height", (height) + "px"  if height > topOffset
    return

  return
