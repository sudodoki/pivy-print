
attachAPIHandlers = ->
  createAPICard = (project_id, id) ->
    extend = (target, other) ->
      target = target or {}
      for prop of other
        target[prop] = other[prop]
      target
    getAttr = (xml, key) ->
      $(xml).find(key).text()
    chrome.storage .sync.get 'pivotal_api_key', (result) ->
      print_id = "print_story_#{id}"
      $.ajax
        type: "GET"
        dataType: "xml"
        beforeSend: (request) ->
          request.setRequestHeader("X-TrackerToken", result.pivotal_api_key)
        url: "https://www.pivotaltracker.com/services/v3/projects/#{project_id}/stories/#{id}"
        success: (cardInfo, status, xhr) ->
          story_points = if $(cardInfo).find('estimate').length
            ' (' + getAttr(cardInfo, 'estimate') + ') '
          else
            ''
          toAdd = {}
          if params = $('#story_template').data('params')?.split(', ')
            for param in params
              toAdd[param] = getAttr(cardInfo, param)
            console.log toAdd
          info = extend(toAdd, {
              print_id
              id
              name: getAttr(cardInfo, 'name')
              story_type: getAttr(cardInfo, 'story_type')
              story_points
            })
          console.log info
          div = Mustache.render $('#story_template').text(), info
          $('#print-area').append(div)

        error: (xhr, error, status) ->
          if status is 'Unauthorized'
            alert 'Either wrong or absent API key. To fix this, click pivy-print icon'
          else
            alert "Something went wrong. Tell our flying monkeys that. Status: #{status}"

  $(document).on 'click', 'header.preview .selector', (e) ->
    $this = $(@)
    $story = $this.closest('.story')
    classInfo = $story.attr('class').split(' ')
    project_id = window.location.pathname.match(/projects\/(\d+)/)[1]
    id = ($.grep classInfo, (elem) ->
      elem.match(/story_\d+/))[0].split('_')[1]
    if $this.hasClass('selected')
      createAPICard(project_id, id)
    else
      $("#print_story_#{id}").remove()

attachDOMHandlers = ->
  $(document).on 'click', 'header.preview .selector', (e) ->
    $this = $(@)
    $story = $this.closest('.story')
    classInfo = $story.attr('class').split(' ')
    id = ($.grep classInfo, (elem) ->
      elem.match(/story_\d+/))[0].split('_')[1]
    type = ($.grep classInfo, (elem) ->
      elem.match(/(?:bug)|(?:chore)|(?:feature)/))[0]
    name = $story.find('.story_name').html()
    story_points = if (points = $story.find('.meta').text()) isnt '-1' then "(#{points})" else ''
    print_id = "print_story_#{id}"
    if $this.hasClass('selected')
      div = Mustache.render $('#story_template').text(), {
        print_id
        id
        name: name
        story_type: type
        story_points
      }
      $('#print-area').append(div)
    else
      $("##{print_id}").remove()

$ ->
  $(document).ready ->
    $('head').append("<style id='optional_css' type='text/css'></style>")
    $('head').append("<script src='#{ chrome.extension.getURL("js/mustache.js") }'></script>")
    $('body').append("<div id='print-area'></div>")
    $('body').append("<script type='text/html' id='story_template'></script>")

    chrome.storage.sync.get 'additional_params', (result) ->
      console.log result.additional_params
      # TODO: either remove extra logic or improve.
      # if (params = result.additional_params)
      if (params = [
        'id',
        'project_id',
        'story_type',
        'url',
        'current_state',
        'description',
        'name',
        'story_type',
        'requested_by',
        'owned_by',
        'created_at',
        'updated_at',
        'labels'
        ])
        $('#story_template').data 'params', params.join(', ')

    chrome.storage.sync.get 'template', (result) ->
      if (template = result.template)
        $('#story_template').text(template)
      else
        $.when($.get(chrome.extension.getURL("default_story.html"))).done (response) ->
          $('#story_template').text(response)

    chrome.storage.sync.get 'optional_css', (result) ->
      if (cssText = result.optional_css)
        $('#optional_css').text(cssText)
      else
        $.when($.get(chrome.extension.getURL("css/default.css"))).done (response) ->
          $('#optional_css').text(response)

    chrome.storage.sync.get 'pivotal_method', (result) ->
      if result.pivotal_method is "API"
        attachAPIHandlers()
      else
        attachDOMHandlers()



    $(document).on 'click', '.button.stories.menu', (e) ->
      $this = $(@)
      unless $('#print').length
        $this.find('.items').append("<li id='print' class='item'><span class='disabled'>Print</span></li>")
      if $this.find('.count').length
        $('#print span').removeClass('disabled')
      else
        $('#print span').addClass('disabled')

  $(document).on 'click', '#print', ->
    return if $(@).find('span').hasClass('disabled')
    window.print()
