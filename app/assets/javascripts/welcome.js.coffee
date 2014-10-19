# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

  $("body").on("input propertychange", ".floating-label-form-group", (e) ->
    $(this).toggleClass "floating-label-form-group-with-value", !!$(e.target).val()
  ).on("focus", ".floating-label-form-group", ->
    $(this).addClass "floating-label-form-group-with-focus"
  ).on "blur", ".floating-label-form-group", ->
    $(this).removeClass "floating-label-form-group-with-focus"


  # Closes the Responsive Menu on Menu Item Click
  $(".navbar-collapse ul li a").click ->
    $(".navbar-toggle:visible").click()

  $(window).scroll ->
    if $(this).scrollTop() > 300
      $(".navbar-default").addClass "navbar-shrink"
    else
      $(".navbar-default").removeClass "navbar-shrink"

  $("form#loginForm").bind "ajax:success", (e, data, status, xhr) ->
    window.location.replace '/admin'

  $("form#loginForm").bind "ajax:error", (e, data, status, xhr) ->
    login_error = $(this).find '#login-error'
    login_error.empty()
    login_error.text data.responseText

  $("form#registrationForm").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      window.location.replace '/admin'
    else
      email_error = $(this).find '#email-error'
      codeship_api_token_error = $(this).find '#codeship-api-token-error'
      password_error = $(this).find '#password-error'
      password_confirmation_error = $(this).find '#password-confirmation-error'

      email_error.empty()
      codeship_api_token_error.empty()
      password_error.empty()
      password_confirmation_error.empty()

      if data.errors.email
        email_error.append "<ul role='alert'></ul>"
        con = email_error.find 'ul'
        for error in data.errors.email
          con.append "<li>#{error}</li>"

      if data.errors.codeship_api_token
        codeship_api_token_error.append "<ul role='alert'></ul>"
        con = codeship_api_token_error.find 'ul'
        for error in data.errors.codeship_api_token
          con.append "<li>#{error}</li>"

      if data.errors.password
        password_error.append "<ul role='alert'></ul>"
        con = password_error.find 'ul'
        for error in data.errors.password
          con.append "<li>#{error}</li>"

      if data.errors.password_confirmation
        password_confirmation_error.append "<ul role='alert'></ul>"
        con = password_confirmation_error.find 'ul'
        for error in data.errors.password_confirmation
          con.append "<li>#{error}</li>"
