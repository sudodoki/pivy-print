createCard = (project_id, id) ->
  chrome.storage.local.get 'api_key', (result) ->
    print_id = "print_story_#{id}"
    $.ajax
      type: "GET"
      dataType: "xml"
      beforeSend: (request) ->
        request.setRequestHeader("X-TrackerToken", result.api_key)
      url: "https://www.pivotaltracker.com/services/v3/projects/#{project_id}/stories/#{id}"
      success: (cardInfo, status, xhr) -> 
        story_points = if $(cardInfo).find('estimate').length
          " (" + $(cardInfo).find('estimate').text() + ') '
        else
          ''
        div = """
        <div id='#{print_id}' class='card task normal background'>
          <div class='story-identifier'>##{id}</div>
          <div class='description'>#{$(cardInfo).find('name').text()}<br></div>
          <div class='tags'>#{$(cardInfo).find('story_type').text()} #{story_points} </div>
        </div>"""
        $('#print-area').append(div)

      error: (xhr, error, status) ->
        if status is 'Unauthorized'
          alert 'Set your API key. To do so, click pivy-print icon'
        else
          alert "Something went wrong. Tell our flying monkeys that. Status: #{status}"
$ ->
  $(document).ready ->
    $('body').append("<div id='print-area'></div>")

    $(document).on 'click', 'header.preview .selector', (e) ->
      $this = $(@)
      $story = $this.closest('.story')
      classInfo = $story.attr('class').split(' ')
      project_id = window.location.pathname.match(/projects\/(\d+)/)[1]
      id = ($.grep classInfo, (elem) ->
        elem.match(/story_\d+/))[0].split('_')[1]
      if $this.hasClass('selected')
        createCard(project_id, id)
      else
        $("#print_story_#{print_id}").remove()

    $(document).on 'click', '.button.stories.menu', (e) ->
      $this = $(@)
      $this.find('.items').append("<li id='print' class='item'><span class='disabled'>Print</span></li>") unless $('#print').length
      if $this.find('.count').length
        $('#print span').removeClass('disabled')
      else
        $('#print span').addClass('disabled')

  $(document).on 'click', '#print', ->
    return if $(@).find('span').hasClass('disabled')
    window.print()