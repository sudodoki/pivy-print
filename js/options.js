// Generated by CoffeeScript 1.6.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  $(function() {
    var rerender, updateCSS, updateExtra, updateHTML;
    updateHTML = function(template) {
      $('#story_template').val(template);
      return rerender(template);
    };
    updateExtra = function(template) {
      var additional, attr, attrs, defaults, _i, _len;
      defaults = ['print_id', 'id', 'name', 'story_type', 'story_points'];
      additional = [];
      attrs = template.match(/\{\{\s*([\w_-]*\s*)\}\}/gm);
      for (_i = 0, _len = attrs.length; _i < _len; _i++) {
        attr = attrs[_i];
        attr = attr.slice(2, -2).replace(/\s+/g, '');
        if (__indexOf.call(defaults, attr) < 0) {
          additional.push(attr);
        }
      }
      $('#story_template').data('params', additional);
      return console.log(additional);
    };
    rerender = function(template) {
      var div, stories, story, _i, _len, _results;
      stories = [
        {
          print_id: 'print_story_random_id_here',
          id: 123456789,
          name: "Damage report! I recommend you don't fire until you're within 40,000 kilometers.",
          story_type: 'bug'
        }, {
          print_id: 'print_story_random_id_here2',
          id: 234567891,
          name: 'Some days you get the bear, and some days the bear gets you. Maybe if we felt any human loss as keenly as we feel one of those close to us, human history would be far less bloody.',
          story_type: 'feature',
          story_points: '(1)'
        }, {
          print_id: 'print_story_random_id_here3',
          id: 345678912,
          name: 'Then maybe you should consider this: if anything happens to them, Starfleet is going to want a full investigation.',
          story_type: 'chore'
        }
      ];
      $('#print-area').empty();
      _results = [];
      for (_i = 0, _len = stories.length; _i < _len; _i++) {
        story = stories[_i];
        div = Mustache.render(template, story);
        _results.push($('#print-area').append(div));
      }
      return _results;
    };
    updateCSS = function(cssText) {
      $('#optional_css').text(cssText);
      return $('#css_edit').val(cssText);
    };
    chrome.storage.sync.get('template', function(result) {
      if (!result.template) {
        return $.when($.get(chrome.extension.getURL("default_story.html"))).done(function(story_template) {
          return updateHTML(story_template);
        });
      } else {
        return updateHTML(result.template);
      }
    });
    chrome.storage.sync.get('optional_css', function(result) {
      if (!result.optional_css) {
        return $.when($.get(chrome.extension.getURL("default.css"))).done(function(optional_css) {
          return updateCSS(optional_css);
        });
      } else {
        return updateCSS(result.optional_css);
      }
    });
    $('#update_css').on('click', function(e) {
      var optional_css;
      optional_css = $('#css_edit').val();
      return updateCSS(optional_css);
    });
    $('#update_html').on('click', function(e) {
      var template;
      template = $('#story_template').val();
      updateExtra(template);
      return rerender(template);
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
    $('#toggle_html').on('click', function() {
      return $('#template_edit_block').toggle();
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
          $("[name='api_key']").attr('disabled', 'disabled');
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
      chrome.storage.sync.set({
        "template": $('#story_template').val()
      });
      chrome.storage.sync.set({
        'additional_params': $('#story_template').data('params')
      });
      $('.notify').fadeIn('fast');
      setTimeout((function() {
        return $('.notify').fadeOut('fast');
      }), 3000);
      return $("[name='api_key']").removeAttr('disabled');
    });
  });

}).call(this);
