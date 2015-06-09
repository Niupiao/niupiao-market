# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#quantity").change ->
    currentQuantity = $(this).val();
    $.ajax(
        method: "POST",
        url: update_cart,
        data: {val: currentQuantity}
        );
