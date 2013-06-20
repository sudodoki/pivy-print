$ ->
  $(document).ready ->
    $('body').append("<div id='print-area'></div>")

    $(document).on 'click', 'header.preview .selector', (e) ->
      $this = $(@)
      $story = $this.closest('.story')
      classInfo = $story.attr('class').split(' ')
      id = ($.grep classInfo, (elem) ->
        elem.match(/story_\d+/))[0].split('_')[1]
      type = ($.grep classInfo, (elem) ->
        elem.match(/(?:bug)|(?:chore)|(?:feature)/))[0]
      title = $story.find('.story_name').html()
      story_points = if (points = $story.find('.meta').text()) isnt '-1' then "(#{points})" else ''
      print_id = "print_story_#{id}"
      if $this.hasClass('selected')
        div = "<div id='#{print_id}' class='card task normal background'><div class='story-identifier'>##{id}</div><div class='description'>#{title}<br></div><div class='tags'>#{type} #{story_points} </div></div>"
        $('#print-area').append(div)
      else
        $("##{print_id}").remove()

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