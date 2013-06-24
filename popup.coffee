$ ->
  window.firstTimeText = """ <p class='first_time'> 
        We need your API key in order to use the API. To set it, visit 
        your Pivotal Tracker profile page and search
        for API TOKEN section (bottom of the page) and then copy value to the input below.
      </p>"""

  setInput = (placeholder) ->
    $("#wrapper").html """ <form action='/submit' id='key_form'>
          <label> Your API KEY IS </label>
          <input type='text' id='api_key' placeholder='#{placeholder}'></input>   
          <input type='submit' value='Set key'>
        </form>
        """

  setReadOnly = (value) ->
    $("#wrapper").html """ <form action='/submit' id='key_form'>
        <label> Your API KEY IS </label>
        <input disabled readonly type='text' id='api_key' value='#{value}'></input>   
        <input type='submit' value='Change key'>
      </form>
    """


  chrome.storage.onChanged.addListener (changes, namespace) ->
    setReadOnly changes.api_key.newValue

  chrome.storage.local.get('api_key', (result) ->
    unless result.api_key
      setInput 'Your API key goes here'
      $("#key_form").before(firstTimeText)
      $('#key_form label').remove()
    else
      setReadOnly result.api_key
  )


  $(document).on 'submit', '#key_form', (e) ->
    e.preventDefault()
    switch $('#key_form [type=submit]').val()
      when 'Change key' then setInput($('#api_key').val())
      when 'Set key'
        api_key = $('#api_key').val()
        chrome.storage.local.set {api_key}
        setReadOnly api_key

