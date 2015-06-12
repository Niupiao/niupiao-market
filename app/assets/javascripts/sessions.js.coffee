# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    $(".quantity_select").change ->
        $.ajax "update_cart",
            method: "POST",
            data: {quantityUpdated: $(".quantity_select").val(), id: $('.quantity_select').attr('id').substring(1,5) },
            dataType: "script",
            error: (jqXHR, textStatus, errorThrown) ->
                console.log("AJAX error: #{textStatus}")
            success: (data, textStatus, jqXHR) ->
                console.log("AJAX OK")
            
