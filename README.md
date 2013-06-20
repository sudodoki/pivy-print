# Pivy-print
Chrome extension to print cards, similar to those, generated by [https://taskcardmaker.appspot.com](https://taskcardmaker.appspot.com/editor) from Pivotal Tracker.

## How to install
To install extension, you'll have to obtain its source
``` git clone git@github.com:sudodoki/pivy-print.git ```
Click the Chrome menu icon ![three lines icon](http://developer.chrome.com/static/images/hotdogmenu.png)  and select Extensions from the Tools menu. Ensure that the "Developer mode" checkbox in the top right-hand corner is checked. Now you can reload extensions, load an unpacked directory of files as if it were a packaged extension, and more. Click 'Load unpacked extensions...' and select folder with plugin.
Now on your pivotal project page you should see the extra item in 'Stories ▼' dropdown - Print ![screenshot](https://raw.github.com/sudodoki/pivy-print/images/print_disabled_select.png)  
After selecting some stories, click the Print button from dropdown
![screenshot](https://raw.github.com/sudodoki/pivy-print/images/print_enabled_select.png)  
??????  
![Profit](https://raw.github.com/sudodoki/pivy-print/images/print_version.png)

Tested with Chrome 26.

## TODO

*Add text fields to edit cards before print.  
*Considering this: next version might work with pivotal API to provide full info on stories (now only story titles are used).  


