// Generated by CoffeeScript 1.6.3
(function() {
  chrome.browserAction.onClicked.addListener(function() {
    return chrome.tabs.create({
      url: "options.html"
    });
  });

}).call(this);
