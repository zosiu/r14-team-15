# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require jquery.easing.min

#!
# * Start Bootstrap - Freelancer Bootstrap Theme (http://startbootstrap.com)
# * Code licensed under the Apache License v2.0.
# * For details, see http://www.apache.org/licenses/LICENSE-2.0.
#

# jQuery for page scrolling feature - requires jQuery Easing plugin
$ ->
  $(".page-scroll a").bind "click", (event) ->
    $anchor = $(this)
    $("html, body").stop().animate
      scrollTop: $($anchor.attr("href")).offset().top
    , 1500, "easeInOutExpo"
    event.preventDefault()

# Floating label headings for the contact form
$ ->
  $("body").on("input propertychange", ".floating-label-form-group", (e) ->
    $(this).toggleClass "floating-label-form-group-with-value", !!$(e.target).val()
  ).on("focus", ".floating-label-form-group", ->
    $(this).addClass "floating-label-form-group-with-focus"
  ).on "blur", ".floating-label-form-group", ->
    $(this).removeClass "floating-label-form-group-with-focus"

# Highlight the top nav as scrolling occurs
$("body").scrollspy target: ".navbar-fixed-top"

# Closes the Responsive Menu on Menu Item Click
$(".navbar-collapse ul li a").click ->
  $(".navbar-toggle:visible").click()

$ ->
  $(window).scroll ->
    if $(this).scrollTop() > 300
      $(".navbar-default").addClass "navbar-shrink"
    else
      $(".navbar-default").removeClass "navbar-shrink"
