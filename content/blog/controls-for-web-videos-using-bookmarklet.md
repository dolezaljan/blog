---
title: "Controls for Web Videos Using Bookmarklet"
date: 2021-04-30T22:13:45+02:00
draft: false
tags: ["en", "productivity", "media", "scripting"]
comments: true
---

Few years ago I had an urge to watch all the videos with higher speed to save the time. However not all the web players do have controls to speed up or slow down the video. No need to worry, there is a remedy! The simplest solution I found was usage of bookmarklets: bookmark in your browser that has the URL filled with a piece of javascript code. With the right code you can manipulate the \<[video](https://www.w3schools.com/html/html5_video.asp)\>s present in the web page.

<!--more-->

---

## TL;DR

TIME is everything, so just add the following bookmarks and be more productive tonight!

First of all make sure your bookmark bar is visible. If not press `Ctrl + Shift + B` which toggles bar visibility in Chrome and Firefox.

Now perform right click on the bookmark bar and select `Add page...` or `New Bookmark...` respectively.

![bookmarks](/files/img/moz_bookmark.png)

Fill desired functionalities listed below and you are all set!

| **action**              | **Name**       | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** |
| ---                     | :---:          | ---      |
| *speed up by 0.2x*              | +              | `javascript: (function(){inc=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate+=inc;vids[key].playbackRate+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate+=inc;frmVids[key].playbackRate+=inc;}}}})()` | 
| &nbsp; | | |
| *slow down by 0.2x*             | -              | `javascript: (function(){dec=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate-=dec;vids[key].playbackRate-=dec;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate-=dec;frmVids[key].playbackRate-=dec;}}}})()` | 
| &nbsp; | | |
| *restore default speed* | 1x             | `javascript: (function(){speed=1.0;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate=speed;vids[key].playbackRate=speed;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate=speed;frmVids[key].playbackRate=speed;}}}})()` | 
| &nbsp; | | |
| *skip video (ad)*       | >>             | `javascript: (function(){vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime=vids[key].duration;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime=frmVids[key].duration;}}}})()` | 
| &nbsp; | | |
| *go back 10 seconds*    | <              | `javascript: (function(){inc=-10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()` |
| &nbsp; | | |
| *go forward 10 seconds* | >              | `javascript: (function(){inc=10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()` |

## Scope

These features will work only on the video content that is delivered by the means of HTML tag \<[video](https://www.w3schools.com/html/html5_video.asp)\>. As the other ways of delivering motion picture content practically disappeared and were replaced by \<video\> the use of these bookmarklets became broader. I am aware it is not perfect and it will not work everywhere, but this is opportunity for your improvements. I'll be looking forward to them in the comments section!

## Code explained

Let's dismantle now one of the bookmarklets:

|                                                                                               |     |
|   ---                                                                                         | --- |
|`javascript: (function ()                                                `                     |     |
|`{                                                                       `                     |     |
|&nbsp;&nbsp;`inc = 0.2;                                                        `               | Set increment of playback rate.   |
|&nbsp;&nbsp;`vids = document.getElementsByTagName("video");                    `               | Find all \<[video](https://www.w3schools.com/html/html5_video.asp)\>s.   |
|&nbsp;&nbsp;`for (key in vids)                                                 `               | For each of found videos...    |
|&nbsp;&nbsp;`{                                                                 `               |     |
|&nbsp;&nbsp;&nbsp;&nbsp;`vids[key].defaultPlaybackRate += inc;                             `   | ...increase playback rates.    |
|&nbsp;&nbsp;&nbsp;&nbsp;`vids[key].playbackRate += inc;                                    `   |     |
|&nbsp;&nbsp;`};                                                                `               |     |
|&nbsp;&nbsp;`allframes = document.getElementsByTagName("iframe");              `               | Find all \<[iframe](https://www.w3schools.com/tags/tag_iframe.asp)\>s, where other    |
|                                                                                               | \<video\>s could be hiding.    |
|&nbsp;&nbsp;`for (frm in allframes)                                            `               | For each frame...    |
|&nbsp;&nbsp;`{                                                                 `               |     |
|&nbsp;&nbsp;&nbsp;&nbsp;`curFrm = allframes[frm].contentDocument;                  `           | ...get HTML [content](https://www.w3schools.com/jsref/prop_frame_contentdocument.asp),...    |
|&nbsp;&nbsp;&nbsp;&nbsp;`if (curFrm != null && curFrm != undefined)                `           | ...filter non-empty ones and...    |
|&nbsp;&nbsp;&nbsp;&nbsp;`{                                                         `           |     |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`frmVids = curFrm.getElementsByTagName("video");   `       | ...do the same as above.    |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`for (key in frmVids)                              `       |     |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`{                                                 `       |     |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`frmVids[key].defaultPlaybackRate += inc;  `   |     |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`frmVids[key].playbackRate += inc;         `   |     |
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`}                                                 `       |     |
|&nbsp;&nbsp;&nbsp;&nbsp;`}                                                         `           |     |
|&nbsp;&nbsp;`}                                                                 `               |     |
|`})()                                                                    `                     |     |



All other listed bookmarklets are mere variations of the one explained above. Use [JS Beautify](https://www.prettifyjs.net/) to get more readable code.

This is the list of \<video\> tag properties that we used:

- [defaultPlaybackRate](https://www.w3schools.com/Tags/av_prop_defaultplaybackrate.asp)
- [playbackRate](https://www.w3schools.com/Tags/av_prop_playbackrate.asp)
- [currentTime](https://www.w3schools.com/Tags/av_prop_currentTime.asp)
- [duration](https://www.w3schools.com/Tags/av_prop_duration.asp)

## Enjoy!

If you get any ideas to this, let me know!
