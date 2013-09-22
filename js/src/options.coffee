$ ->
  # chrome.storage.sync.remove('optional_css')
  updateCSS = (cssText) ->
    $('#optional_css').text(cssText)
    $('#css_edit').val(cssText)

  chrome.storage.sync.get 'optional_css', (result) ->
    unless result.optional_css
      $.when($.get(chrome.extension.getURL("default.css"))).done (optional_css) ->
        updateCSS optional_css
    else
      updateCSS result.optional_css

  $('#update_css').on 'click', (e) ->
    optional_css = $('#css_edit').val()
    updateCSS optional_css

  chrome.storage.sync.get 'pivotal_method', (result) ->
    if result.pivotal_method
      $("input[value=#{result.pivotal_method}]").click()
    if result.pivotal_method is 'API'
      chrome.storage.sync.get 'pivotal_api_key', (result) ->
        $("[name='api_key']").val(result.pivotal_api_key) if result.pivotal_api_key

  $('#toggle_css').on 'click', ->
    $('#css_edit_block').toggle()

  $('[name="method"]').on 'change', (e) ->
    if $(@).val() is 'API'
      $(".api_key_input").show()
    else
      $(".api_key_input").hide()

  $('#options').on 'submit', (e) ->
    e.preventDefault()
    return if $("input[name='method']:checked").length is 0
    switch $("input[name='method']:checked").val()
      when 'API'
        chrome.storage.sync.set {'pivotal_method': 'API'}
        chrome.storage.sync.set {'pivotal_api_key': $("input[name='api_key']").val()}
      when 'DOM'
        $("[name='api_key']").attr('disabled', 'disabled')
        chrome.storage.sync.set {'pivotal_method': 'DOM'}
      else
        return alert('Something went wrong')
    chrome.storage.sync.set {"optional_css": $('#css_edit').val()}
    $('.notify').fadeIn('fast')
    setTimeout((->
      $('.notify').fadeOut('fast')
    ), 3000)
    $("[name='api_key']").removeAttr('disabled')
