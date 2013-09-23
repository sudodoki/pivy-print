$ ->
  # chrome.storage.sync.remove('optional_css')
  updateHTML = (template) ->
    $('#story_template').val(template)
    rerender(template)

  updateExtra = (template) ->
    defaults = ['print_id', 'id', 'name', 'story_type', 'story_points']
    additional = []
    attrs = template.match(/\{\{\s*([\w_-]*\s*)\}\}/gm)
    for attr in attrs
      attr = attr.slice(2, -2).replace(/\s+/g, '')
      unless attr in defaults
        additional.push attr
    $('#story_template').data('params', additional)
    console.log(additional)

  rerender = (template) ->
    stories = [
      {
        print_id: 'print_story_random_id_here'
        id: 123456789
        name: "Damage report! I recommend you don't fire until you're within 40,000 kilometers."
        story_type: 'bug'
      },
      {
        print_id: 'print_story_random_id_here2'
        id: 234567891
        name: 'Some days you get the bear, and some days the bear gets you. Maybe if we felt any human loss as keenly as we feel one of those close to us, human history would be far less bloody.'
        story_type: 'feature'
        story_points: '(1)'
      },
      {
        print_id: 'print_story_random_id_here3'
        id: 345678912
        name: 'Then maybe you should consider this: if anything happens to them, Starfleet is going to want a full investigation.'
        story_type: 'chore'
      }
    ]
    $('#print-area').empty()
    for story in stories
      div = Mustache.render template, story
      $('#print-area').append(div)

  updateCSS = (cssText) ->
    $('#optional_css').text(cssText)
    $('#css_edit').val(cssText)

  chrome.storage.sync.get 'template', (result) ->
    unless result.template
      $.when($.get(chrome.extension.getURL("default_story.html"))).done (story_template) ->
        updateHTML story_template
    else
      updateHTML result.template

  chrome.storage.sync.get 'optional_css', (result) ->
    unless result.optional_css
      $.when($.get(chrome.extension.getURL("default.css"))).done (optional_css) ->
        updateCSS optional_css
    else
      updateCSS result.optional_css

  $('#update_css').on 'click', (e) ->
    optional_css = $('#css_edit').val()
    updateCSS optional_css

  $('#update_html').on 'click', (e) ->
    template = $('#story_template').val()
    updateExtra template
    rerender template

  chrome.storage.sync.get 'pivotal_method', (result) ->
    if result.pivotal_method
      $("input[value=#{result.pivotal_method}]").click()
    if result.pivotal_method is 'API'
      chrome.storage.sync.get 'pivotal_api_key', (result) ->
        $("[name='api_key']").val(result.pivotal_api_key) if result.pivotal_api_key

  $('#toggle_css').on 'click', ->
    $('#css_edit_block').toggle()

  $('#toggle_html').on 'click', ->
    $('#template_edit_block').toggle()

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
    chrome.storage.sync.set {"template": $('#story_template').val()}
    chrome.storage.sync.set {'additional_params': $('#story_template').data('params')}
    $('.notify').fadeIn('fast')
    setTimeout((->
      $('.notify').fadeOut('fast')
    ), 3000)
    $("[name='api_key']").removeAttr('disabled')
