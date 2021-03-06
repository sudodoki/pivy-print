# Pivy-print
Chrome extension to print cards, similar to those, generated by [https://taskcardmaker.appspot.com](https://taskcardmaker.appspot.com/editor) from Pivotal Tracker. There're few versions which might merge in the future (be sure to check [version section](#versions))

## How to install
To install extension, you'll have to obtain its source
``` git clone git@github.com:sudodoki/pivy-print.git ```
or download the [zip archive](https://github.com/sudodoki/pivy-print/archive/master.zip).
Click the Chrome menu icon ![three lines icon](http://developer.chrome.com/static/images/hotdogmenu.png)  and select Extensions from the Tools menu. Ensure that the "Developer mode" checkbox in the top right-hand corner is checked. Now you can reload extensions, load an unpacked directory of files as if it were a packaged extension, and more. Click 'Load unpacked extensions...' and select folder with plugin.
Before using the plugin, you may have to set some options (otherwise it will be defaulted to using DOM parsing). Click plugin icon ![printer](https://raw.github.com/sudodoki/pivy-print/master/icon.png) in your address bar panel. You should see the options page:  

![option_page](https://raw.github.com/sudodoki/pivy-print/images/options_page.png)  
You can use either simple DOM parsing (same, as v0.5 of the plugin) or API (will come in handy when we add more fields) - in latter case you'll have to input the Pivotal API key (you can find it at the bottom of [your profile page](https://www.pivotaltracker.com/profile) ).
Option page also grants you ability to edit cards css (as well as of other elements, since it's just being injected into page, but shhh..)
Now on your pivotal project page you should see the extra item in 'Stories ▼' dropdown - Print  
![screenshot](https://raw.github.com/sudodoki/pivy-print/images/print_disabled_select.png)  
After selecting some stories, click the Print button from dropdown
![screenshot](https://raw.github.com/sudodoki/pivy-print/images/print_enabled_select.png)  
??????  
![Profit](https://raw.github.com/sudodoki/pivy-print/images/print_version.png)

Tested with Chrome 26.

## Customize pivy-print
In order to meet the different needs and circumstances that arise across various agile-based teams, you might need to somehow change pivy-print cards so that it's easier/more useful for you to use. (Be sure to [write about it](https://groups.google.com/forum/#!forum/pivy-print-general), so that it might be added to the extension)


### Cusomizing CSS
On the options page (if in trouble finding it, consult [installation section](#how-to-install)) press 'Toggle the css edit' button:  
[![press to enlarge](https://raw.github.com/sudodoki/pivy-print/images/edit_css1_thumb.jpg)](https://raw.github.com/sudodoki/pivy-print/images/edit_css1.jpg)  
Edit css in field. To see the outcome, press 'Check the css' button:  
[![press to enlarge](https://raw.github.com/sudodoki/pivy-print/images/edit_css2_thumb.jpg)](https://raw.github.com/sudodoki/pivy-print/images/edit_css2.jpg)  
In case you're satisfied, press 'Save options' at the bottom, otherwise just close/refresh tab to keep your previous settings.  
[![press to enlarge](https://raw.github.com/sudodoki/pivy-print/images/edit_css3_thumb.jpg)](https://raw.github.com/sudodoki/pivy-print/images/edit_css3.jpg)

### Customizing cards' template
In your card template you can add any static info, text decoration etc. Also, if you're using API calls (you've inserted your key on options page), you can use next fields:
+id, 
+project_id, 
+story_type, 
+url, 
+current_state, 
+description, 
+name, 
+requested_by, 
+owned_by, 
+created_at, 
+updated_at, 
+labels.

Sample usage:
[![Like a Sir](https://raw.github.com/sudodoki/pivy-print/images/sir_template_thumb.jpg)](https://raw.github.com/sudodoki/pivy-print/images/sir_template.jpg)
Sources at [gist/sudodoki/6877305](https://gist.github.com/sudodoki/6877305)

## Versions
So, there're these versions in the wild:
* [v0.5](https://github.com/sudodoki/pivy-print/tree/v0.5). [Download zip](https://github.com/sudodoki/pivy-print/archive/v0.5.zip). Provides basic cards based on html parsing. Cards state title, type, id and points (for features). Just plug it in - no settings, no API keys, check some checkboxes for stories and click print to print those out.
* [v0.8](https://github.com/sudodoki/pivy-print/tree/v0.8). [Download zip](https://github.com/sudodoki/pivy-print/archive/v0.8.zip). Provides basic cards based on API responses. Cards state title, type, id and points (for features). Need to input API key using extension's popup.
* [v0.9](https://github.com/sudodoki/pivy-print/tree/v0.9). [Download zip](https://github.com/sudodoki/pivy-print/archive/v0.9.zip). New option page, editable css.

## TODO

* Create firefox extension
* Add themes
* Fix some nested fields to be available in the template.
* Add text fields to edit cards before print.  

## How to contribute

1. Fork the project
Tip: To watch coffee files for changes and recompile them, use `coffee -o js -cw js/src` from folder root, having installed coffee-script (`npm install -g coffee-script')
2. Make one or more commits to the repository.
3. Open a pull request.

You can also consider [opening an issue](https://github.com/sudodoki/pivy-print/issues/new).  

## Support

In case you want to provide your feedback, report an issue, ask for help – go check out [mailing list](https://groups.google.com/forum/#!forum/pivy-print-general)

## The MIT License (MIT)

The MIT License (MIT)

Copyright (c) 2013 sudodoki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION W