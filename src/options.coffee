$ ->
  default_css = """
    #print-area div.card {
      margin: 4px;
      padding: 4px;
      width: 200px;
      height: 200px;
      float: left;
      border-radius: 10px;
      -webkit-box-shadow: 5px 5px 10px #A0A0A0;
      -moz-box-shadow: 5px 5px 10px #A0A0A0;
      box-shadow: 5px 5px 10px #A0A0A0;
    }

    #print-area div.card div {
      overflow: hidden;
    }

    #print-area div.task.background {
        border: 1px solid #8DA404;
        background-color: #F2F5A9;
        background: -moz-linear-gradient(top, #F2F5A9, #D2D589);
        background: -webkit-gradient(linear, left top, left bottom, from(#F2F5A9),
        to(#D2D589) );
    }

    #print-area div.task div {
      margin: 0px;
      padding: 2px;
    }

    #print-area div.task .story-identifier {
      text-align: center;
      height: 20px;
    }

    #print-area div.task.normal.background .story-identifier {
        border-bottom: 1px solid #D2D589;
    }

    #print-area div.task.normal.foreground .story-identifier {
        border-bottom: 1px solid #FEAE00;
    }

    #print-area div.task .tags {
      height: 20px;
      text-align: center;
      font-size: .9em;
      font-style: italic;
    }

    #print-area div.task.normal.background .tags {
        border-top: 1px solid #B2B569;
    }

    #print-area div.task.normal.foreground .tags {
        border-top: 1px solid #FEAE00;
    }


    #print-area div.task .description {
      height: 154px;
      padding: 2px;
    }
  """
  updateCSS = (cssText) ->
    $('#optional_css').text(cssText)
    $('#css_edit').val(cssText)

  chrome.storage.sync.get 'optional_css', (result) ->
    unless result.optional_css
      optional_css = default_css
    else 
      optional_css = result.optional_css
    updateCSS optional_css

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
