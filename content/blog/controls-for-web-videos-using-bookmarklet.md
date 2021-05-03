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

![bookmarks](/files/blog/img/moz_bookmark.png)

Fill desired functionalities listed below and you are all set!

**Pro Tip**: grab the link in the Name column and drop it to your bookmark bar **to install** it.

| **action**              | **Name**       | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Location** |
| ---                     | :---:          | ---      |
| *speed up by 0.2x*              | <a href='javascript: (function(){inc=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate+=inc;vids[key].playbackRate+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate+=inc;frmVids[key].playbackRate+=inc;}}}})()'>+</a>              | `javascript: (function(){inc=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate+=inc;vids[key].playbackRate+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate+=inc;frmVids[key].playbackRate+=inc;}}}})()` |
| &nbsp; | | |
| *slow down by 0.2x*             | <a href='javascript: (function(){dec=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate-=dec;vids[key].playbackRate-=dec;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate-=dec;frmVids[key].playbackRate-=dec;}}}})()'>-</a>              | `javascript: (function(){dec=0.2;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate-=dec;vids[key].playbackRate-=dec;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate-=dec;frmVids[key].playbackRate-=dec;}}}})()` |
| &nbsp; | | |
| *restore default speed* | <a href='javascript: (function(){speed=1.0;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate=speed;vids[key].playbackRate=speed;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate=speed;frmVids[key].playbackRate=speed;}}}})()'>1x</a>             | `javascript: (function(){speed=1.0;vids=document.getElementsByTagName("video");for(key in vids){vids[key].defaultPlaybackRate=speed;vids[key].playbackRate=speed;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].defaultPlaybackRate=speed;frmVids[key].playbackRate=speed;}}}})()` |
| &nbsp; | | |
| *skip video (ad)*       | <a href='javascript: (function(){vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime=vids[key].duration;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime=frmVids[key].duration;}}}})()'>&gt;&gt;</a>             | `javascript: (function(){vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime=vids[key].duration;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime=frmVids[key].duration;}}}})()` |
| &nbsp; | | |
| *go back 10 seconds*    | <a href='javascript: (function(){inc=-10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()'>&lt;</a>             | `javascript: (function(){inc=-10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()` |
| &nbsp; | | |
| *go forward 10 seconds* | <a href='javascript: (function(){inc=10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()'>&gt;</a>              | `javascript: (function(){inc=10;vids=document.getElementsByTagName("video");for(key in vids){vids[key].currentTime+=inc;};allframes=document.getElementsByTagName("iframe");for(frm in allframes){curFrm=allframes[frm].contentDocument;if(curFrm != null && curFrm != undefined){frmVids=curFrm.getElementsByTagName("video");for(key in frmVids){frmVids[key].currentTime+=inc;}}}})()` |

## Scope

These features will work only on the video content that is delivered by the means of HTML tag \<[video](https://www.w3schools.com/html/html5_video.asp)\>. As the other ways of delivering motion picture content practically disappeared and were replaced by \<video\> the use of these bookmarklets became broader. I am aware it is not perfect and it will not work everywhere, but this is opportunity for your improvements. I'll be looking forward to them in the comments section!

## Code explained

Let's dismantle now one of the bookmarklets:

<style>
table:nth-of-type(2)
{
  margin-bottom: 10px;
}
table:nth-of-type(2) td:nth-child(1)
{
  background-color:#202020;
}
pre
{
  border:0px;
  padding:0;
  margin:0;
}
</style>

|                                                                                                    |     |
|   ---                                                                                              | --- |
|{{< highlight js >}}javascript: (function (){{< /highlight >}}                                      |     |
|{{< highlight js >}}{{{< /highlight >}}                                                             |     |
|{{< highlight js >}}  inc = 0.2;{{< /highlight >}}                                                  | Set increment of playback rate.   |
|{{< highlight js >}}  vids = document.getElementsByTagName("video");{{< /highlight >}}              | Find all \<[video](https://www.w3schools.com/html/html5_video.asp)\>s.   |
|{{< highlight js >}}  for (key in vids){{< /highlight >}}                                           | For each of found videos...    |
|{{< highlight js >}}  {{{< /highlight >}}                                                           |     |
|{{< highlight js >}}    vids[key].defaultPlaybackRate += inc;{{< /highlight >}}                     | ...increase playback rates.    |
|{{< highlight js >}}    vids[key].playbackRate += inc;{{< /highlight >}}                            |     |
|{{< highlight js >}}  };{{< /highlight >}}                                                          |     |
| &nbsp;                                                                                             |     |
|{{< highlight js >}}  allframes = document.getElementsByTagName("iframe");{{< /highlight >}}        | Find all \<[iframe](https://www.w3schools.com/tags/tag_iframe.asp)\>s, where other |
|                                                                                                    | \<video\>s could be hiding.    |
|{{< highlight js >}}  for (frm in allframes){{< /highlight >}}                                      | For each frame...    |
|{{< highlight js >}}  {{{< /highlight >}}                                                           |     |
|{{< highlight js >}}    curFrm = allframes[frm].contentDocument;{{< /highlight >}}                  | ...get HTML [content](https://www.w3schools.com/jsref/prop_frame_contentdocument.asp),...    |
|{{< highlight js >}}    if (curFrm != null && curFrm != undefined){{< /highlight >}}                | ...filter non-empty ones and...    |
|{{< highlight js >}}    {{{< /highlight >}}                                                         |     |
|{{< highlight js >}}      frmVids = curFrm.getElementsByTagName("video");{{< /highlight >}}         | ...do the same as above.    |
|{{< highlight js >}}      for (key in frmVids){{< /highlight >}}                                    |     |
|{{< highlight js >}}      {{{< /highlight >}}                                                       |     |
|{{< highlight js >}}        frmVids[key].defaultPlaybackRate += inc;{{< /highlight >}}              |     |
|{{< highlight js >}}        frmVids[key].playbackRate += inc;{{< /highlight >}}                     |     |
|{{< highlight js >}}      }{{< /highlight >}}                                                       |     |
|{{< highlight js >}}    }{{< /highlight >}}                                                         |     |
|{{< highlight js >}}  }{{< /highlight >}}                                                           |     |
|{{< highlight js >}}})(){{< /highlight >}}                                                          |     |

All other listed bookmarklets are mere variations of the one explained above. Use [JS Beautify](https://www.prettifyjs.net/) to get more readable code.

This is the list of \<video\> tag properties that we used:

- [defaultPlaybackRate](https://www.w3schools.com/Tags/av_prop_defaultplaybackrate.asp)
- [playbackRate](https://www.w3schools.com/Tags/av_prop_playbackrate.asp)
- [currentTime](https://www.w3schools.com/Tags/av_prop_currentTime.asp)
- [duration](https://www.w3schools.com/Tags/av_prop_duration.asp)

## Enjoy!

If you get any ideas to this, let me know!
