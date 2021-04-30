---
title: "Setting Up a Blog: The Hard Way"
date: 2019-04-11T22:22:51+02:00
draft: false
tags: ["en", "tech", "scripting", "web", "productivity"]
comments: true
---

The wish to operate my own blog gradually rose over time.
I own a domain that I bougth from the webhosting company [wedos.cz](http://wedos.cz).
Their domains come with the Miniweb service which allows the files to be served statically only.
The service is managed through the web UI and nothing like FTP is present.
Further, unlike other file types, the .html files cannot have subdirs in the URLs leading to them.
Efficient operation of a blog with such limitations is a challenge to be resolved!

<!--more-->

---

<!--## TL;DR

[embed video](https://youtu.be/)
-->

## Find the Right Tools

The blogging solution has to be fast and easy to use.
That brings the plan with two parts.
First: I want the capability to upload my blog with a single command.
Second: I want to have blog generator that is fed with some rather simple source files of individual articles.
When all the parts of the solution are ready, there are three steps necessary whenever writing any new article:

 - 1) Write the article.
 - 2) Regenerate the blog into static files (single command).
 - 3) Re-upload the generated blog containg new article (single command).

Obviously, step 1) is then the hardest one :P.

#### Deploying Files

Since the Miniweb service may be managed only through the web GUI, there is some scripting necessary to automate file deployment through that GUI.

<!--Let's begin with the point 3) at first.-->

Since I have some experience with the end-to-end testing of the front-end javascript applications, first option automating file deployment that came to my mind was
the control script utilizing a headless browser. The js script could be written for the headless browser environment that would perform the upload of the blog files.
Javascript libraries for such tasks provide nowadays beautiful APIs allowing the resulting code of a script to be well readable.
Something like [zombie.js](http://zombie.js.org/) could do the job.
Then the methods such as *fill* to insert data into form fields or *pressButton* to act upon elements may be used.

Another idea was to discover routes used for performing file and website uploads (POST, GET, and friends methods). First, I considered bash script utilizing `curl` or `wget` tool. I guess this option would be slightly less portable to the Windows systems.
Then I browsed through github repositories and only then I found python script that aimed to do exactly what I needed -- upload files and webpages to the miniweb service from wedos.
Its name is [wedos-miniweb-cli](https://github.com/vlna/wedos-miniweb-cli).
Even though it wasn't completely finished I was able to upload and modify web pages in the root of a domain out of box with the following command:

{{< highlight bash >}}
./wedos-miniweb-cli.py -d <domain> -p <base_dir>
{{< /highlight >}}

\<domain\> is target domain, where the files are uploaded and \<base_dir\> is local root directory with all the blog files.

The credentials may be filled to the `~/.netrc` with mode `rw-------`.
This way the repeated manual insertion of the credentials is avoided since they can be requested by the python script.
Entry in the `~/.netrc` looks as follows:

{{< highlight netrc >}}
machine client.wedos.com
        login user@log.in
        password mysupersecretpassword
{{< /highlight >}}

I decided to use this python script as a base for my needs.
My [clone](https://github.com/dolezaljan/wedos-miniweb-cli/commits/master) of the repo is extened with the patches allowing the upload of the non-html files.
These must be located under the path `files/*` as a Miniweb's requirement.
I needed to add possibility to upload *multipart/form-data* to the script and the solution is based on [RFC 7578](https://tools.ietf.org/html/rfc7578) and friends.

This is ready-to-use solution that addresses point 3) from the list above.

#### Blog Generator

Since blog is essentially textual thing, it makes sense to me, to have source of the individual posts in a plain text possibly with some in-file configuration and formatting.
Any text editor may be than used to write the posts.
The solution I use is an open-source static site generator -- [Hugo](https://gohugo.io).
With Hugo, the content of a post is stored within one Markdown file.
This ensures easy editability.
At the beginning of the file, there is a configuration of a post including e.g. post's title or post's date.
See an example of post's source code written in Markdown:

{{< highlight markdown >}}
---
title: "Cheap Blog for Price of a Domain"
date: 2019-04-11T22:22:51+02:00
publishdate: 2019-04-11T22:22:51+02:00
image: "files/images/1.jpg"
tags: ["interesting"]
comments: false
draft: false
---

Introduction to my awesome post displayed also in post's brief.

<!--more-->

Further content of a post.

## Section

### Subsection

[link example](http://example.com)

{{< /highlight >}}

Let us take a look at configuration of the Hugo generator in the following lines.

## Go Hugo, Go!

Hugo is fairly configurable static site generator and I believe it's easy to use.
Let's get into it.

(While reading this section, have also a look at [example commits](https://github.com/dolezaljan/blog/commits/example) to see the details.)

### Initial setup

The very important is the appearance of the site.
I searched for the theme that would be clean and found [mediumish-gohugo-theme](https://github.com/lgaida/mediumish-gohugo-theme).
With the theme at hand, there are only few more steps necessary to setup basic blog containing the first post!

 - establish new hugo site
   - `hugo new site myblg`
   - `cd myblg/`
 - select theme for the blog and add it under `themes/` directory
   - `cd themes/`
   - `git submodule add git@github.com:dolezaljan/mediumish-gohugo-theme.git`
 - compile blog to the `public/` directory so the files are ready to be deployed
   - `hugo`
 - debug blog with live reload (used also for preview during writing of new posts)
   - `hugo server -w -v`
 - add new blog post
   - `hugo new posts/setting-up-a-blog-the-hard-way.md`

Now, the base of hugo site contains configuration file `config.toml`.
To give an example, the theme needs to be registered there with line
{{< highlight toml >}}
theme = mediumish-gohugo-theme
{{< /highlight >}}

We may also want to add main menu item that links to the generated site with grid of posts.

{{< highlight toml >}}
[[menu.main]]
    name = "Blog"
    weight = 100
    identifier = "blog"
    url = "/posts.html"
{{< /highlight >}}
(the url links to `/posts.html` as we generated new blog post with `hugo new posts/*.md` so it is located under `posts/` subdir)

Further, there are e.g. configurations of `baseURL`, `languageCode`, or `title`. Some others will be covered in the following sections.

### Configuration for Wedos' Miniweb

The wedos miniweb service requires the static web files in complying format to be uploaded.
The complying format means that the `*.html` files have to be in the root of the domain -- `<domain>/*.html`, whereas the non-html files have to be under `<domain>/files/*` path.

Complying format of a theme is ensured with this [commit](https://github.com/dolezaljan/mediumish-gohugo-theme/commit/c11b35cfd111159914ae19a8caed46e038ccfac4) by moving its `.js` and `.css` files under correct path.
`static/[js/|css/]` becomes `static/files/[js/|css/]`.
The references in shared `.html` files are updated accordingly.

Further, the `config.toml` needs to be updated.
Enabling option `uglyurls`
{{< highlight toml >}}
uglyurls = true
{{< /highlight >}}
turns off directory like URLs ending with slash `/` and shows sites ending with `.html`.
The file names are now generated in complying format, but they might still be in subdirectories.
With the following config option the post is generated in the domain's root.
{{< highlight toml >}}
[permalinks]
  blog = ":year-:month-:day-:title"
{{< /highlight >}}
The post's permalink name may be also customized as shown.

#### Tags

Each post may be categorized with multiple tags.
{{< highlight toml >}}
tags: ["interesting", "web", "tech"]
{{< /highlight >}}

The Hugo generates a site for each tag allowing to display posts that have something in common in one place.
There is need for another slight modification that ensures these sites are also in complying format.

In the `config.toml` another record within `[permalinks]` is added.
{{< highlight toml >}}
  tags = "tags-:title"
{{< /highlight >}}
After that the mediumish template needs one line [patch](https://github.com/dolezaljan/mediumish-gohugo-theme/commit/768dad330397f9e2305525a85e70b1f6ab138a38) so the links to the tag sites are correct.

### Comments

It is possible to add commenting platform disqus to the blog.
To do this, first register at [disqus.com](https://disqus.com/).
Create new site at disqus and use `shortname` from the form field *Website Name* within your `config.toml`:
{{< highlight toml >}}
disqusShortname = "shortname"
{{< /highlight >}}


Then enable comments at arbitrary post by adding the following to the post's header: 
{{< highlight markdown >}}
comments: true
{{< /highlight >}}

### RSS feed

The Hugo generates RSS feed automatically to the file `index.xml`.
It is enough to upload the file under `files/*` and add link to it e.g. to the top menu.
New menu item record in the `config.toml` would be similar to the following.

{{< highlight toml >}}
[[menu.main]]
    name = "RSS"
    weight = 101
    identifier = "rss"
    url = "/files/index.xml"
{{< /highlight >}}

## Automate

The fun part of it all is automation.
For decades (since April 1976) there exists a build automation tool *Make*. As I learned to use it, it accompanies me ever since.
Some might like to write long commands and spent time remembering them especially after long time has passed.
But it is just much more comfortable to store the popular commands at one place -- `Makefile`.
(Similar approach is used by e.g. Node.js projects, which store scripts and other information in the `package.json` file.)

I want to use commands:

 - `make build` to regenerate `public/` directory within which all statically generated sites of a blog are located,
to remove unused pages I don't want to upload,
and potentially to do some other *build* stuff.
 - `make deploy` to upload the pages to online space.
 - `make start` for local development and preview.
 - and standalone `make` that does first `build` action followed by `deploy` action

Then the contents of a Makefile would look similar to the following:

{{< highlight makefile >}}
all: build deploy
build:
        rm -rf public/
        hugo
        rm public/index.html public/404.html
        mv public/index.xml public/files/blog/index.xml
start:
        hugo server -w -v
deploy:
        python wedos-miniweb-cli/wedos-miniweb-cli.py -v -d jandolezal.cz -p ./public/
{{< /highlight >}}

## That's all folks!


