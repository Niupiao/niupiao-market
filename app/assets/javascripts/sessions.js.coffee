# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    $(document).ready ->
        $(".quantity_select").change ->
            $elm = $(this);
            $.ajax "update_cart",
                method: "POST",
                data: { quantity_updated: $elm.val(), id: $elm.attr('id').substring(16) },
                dataType: "script",
                error: (jqXHR, textStatus, errorThrown) ->
                    console.log("AJAX error: #{textStatus}")
                success: (data, textStatus, jqXHR) ->
                    console.log("AJAX OK")

$(document).ready(ready)
$(document).on('page:load', ready)