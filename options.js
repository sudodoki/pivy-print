// Generated by CoffeeScript 1.6.2
(function() {
  $(function() {
    var default_css, updateCSS;

    default_css = "#print-area div.card {\n  margin: 4px;\n  padding: 4px;\n  width: 200px;\n  height: 200px;\n  float: left;\n  border-radius: 10px;\n  -webkit-box-shadow: 5px 5px 10px #A0A0A0;\n  -moz-box-shadow: 5px 5px 10px #A0A0A0;\n  box-shadow: 5px 5px 10px #A0A0A0;\n}\n\n#print-area div.card div {\n  overflow: hidden;\n}\n\n#print-area div.task.background {\n    border: 1px solid #8DA404;\n    background-color: #F2F5A9;\n    background: -moz-linear-gradient(top, #F2F5A9, #D2D589);\n    background: -webkit-gradient(linear, left top, left bottom, from(#F2F5A9),\n    to(#D2D589) );\n}\n\n#print-area div.task div {\n  margin: 0px;\n  padding: 2px;\n}\n\n#print-area div.task .story-identifier {\n  text-align: center;\n  height: 20px;\n}\n\n#print-area div.task.normal.background .story-identifier {\n    border-bottom: 1px solid #D2D589;\n}\n\n#print-area div.task.normal.foreground .story-identifier {\n    border-bottom: 1px solid #FEAE00;\n}\n\n#print-area div.task .tags {\n  height: 20px;\n  text-align: center;\n  font-size: .9em;\n  font-style: italic;\n}\n\n#print-area div.task.normal.background .tags {\n    border-top: 1px solid #B2B569;\n}\n\n#print-area div.task.normal.foreground .tags {\n    border-top: 1px solid #FEAE00;\n}\n\n\n#print-area div.task .description {\n  height: 154px;\n  padding: 2px;\n}";
    chrome.storage.sync.remove('optional_css');
    chrome.storage.sync.remove('pivotal_method');
    chrome.storage.sync.remove('pivotal_api_key');
    updateCSS = function(cssText) {
      $('#optional_css').text(cssText);
      return $('#css_edit').val(cssText);
    };
    chrome.storage.sync.get('optional_css', function(result) {
      var optional_css;

      if (!result.optional_css) {
        optional_css = default_css;
      } else {
        optional_css = result.optional_css;
      }
      return updateCSS(optional_css);
    });
    $('#update_css').on('click', function(e) {
      var optional_css;

      optional_css = $('#css_edit').val();
      return updateCSS(optional_css);
    });
    chrome.storage.sync.get('pivotal_method', function(result) {
      if (result.pivotal_method) {
        $("input[value=" + result.pivotal_method + "]").click();
      }
      if (result.pivotal_method === 'API') {
        return chrome.storage.sync.get('pivotal_api_key', function(result) {
          if (result.pivotal_api_key) {
            return $("[name='api_key']").val(result.pivotal_api_key);
          }
        });
      }
    });
    $('#toggle_css').on('click', function() {
      return $('#css_edit_block').toggle();
    });
    $('[name="method"]').on('change', function(e) {
      if ($(this).val() === 'API') {
        return $(".api_key_input").show();
      } else {
        return $(".api_key_input").hide();
      }
    });
    return $('#options').on('submit', function(e) {
      e.preventDefault();
      if ($("input[name='method']:checked").length === 0) {
        return;
      }
      switch ($("input[name='method']:checked").val()) {
        case 'API':
          chrome.storage.sync.set({
            'pivotal_method': 'API'
          });
          chrome.storage.sync.set({
            'pivotal_api_key': $("input[name='api_key']").val()
          });
          break;
        case 'DOM':
          chrome.storage.sync.set({
            'pivotal_method': 'DOM'
          });
          break;
        default:
          return alert('Something went wrong');
      }
      chrome.storage.sync.set({
        "optional_css": $('#css_edit').val()
      });
      $('.notify').fadeIn('fast');
      return setTimeout((function() {
        return $('.notify').fadeOut('fast');
      }), 3000);
    });
  });

}).call(this);
