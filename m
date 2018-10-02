Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85811F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJBVMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:12:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:57411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:12:07 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McDl1-1gPIaM34kh-00JYBU; Tue, 02
 Oct 2018 16:28:25 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McDl1-1gPIaM34kh-00JYBU; Tue, 02
 Oct 2018 16:28:25 +0200
Date:   Tue, 2 Oct 2018 16:28:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: RUNTIME_PREFIX references in gitconfig variable paths
In-Reply-To: <55733da67095123ced63095aa554970053bef321.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1810021611040.2034@tvgsbejvaqbjf.bet>
References: <e9d5bbec6242e47b1f4141ffd99b276eb6a41347.camel@mad-scientist.net>  <nycvar.QRO.7.76.6.1807041323490.75@tvgsbejvaqbjf.bet> <55733da67095123ced63095aa554970053bef321.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NtnANBCPcuSW94m9E77MDZnjfv/tVfkZDryULCvZILYtHFhVzMQ
 sNuQWZdzZjBA3Ll98UwjI3DnbTNNDT8DNmnYNrIXcGCpsIP0Esd1RuUQWXXUgl2Pk1ygb8C
 FtWLumGENawMuwSrBCVCQRUaHkc5SHw0Y6wVhfS7AOlEwTC5HSpP53vtfNKWmdA1antcuUv
 YlKM3kQVcJdqDlAGBq6SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RMY7hvTFsB8=:m5lhCYyFOhEFItsN7mkzji
 hfu4BukNaSGfXVhM8J/lAi3lsS+4fLasxlRtkmNHfvKWkb3wDz3h/EPuXOUDKbUHDvBMzhT92
 JspK1xN2vly/K9kUBFGNgzsn6RazskrU6pFWDOMrQSy+JXprHnMBPugoupY5m/ReFfxq/Rdor
 8GqWwWEWoQlM18YthZNncBm2eAte4RLF8com1/BDo+isIOlAxoGDa2Ko8Wj/NtQfJiAiiAZsv
 M8KCgfJSX0l3M0rJw801SHQWZUGTuGwgqaUi3Bswbda0e5q0VzsGA1WliIT4kegfV5SxgVb1p
 MEL7XftzTlSyd9CaB33GtPXggcmww8Sr0f6V/AhkJ2LSoFUNP94qQ/sW/XTmLYXXP5IZHAjE1
 hHm4ZrUkogoAZDfmQYd5rLyYmI95c2u9T42Kvag8VQILdJBbbjo3euVzS07Jn0IYhEJAbQ7ij
 1OE97LSmCohEvX/U7qP9Z3qKV/tz6HXQUCDZ91XdwjvEE0okSMc4NhEZf4Agd2bVUgbU/ju3q
 mmxKuyofULl7HY6YOSEw6nDKVpQuZIiwxnkKSQ/zXzASFobKkg5Q+ZfAYd/wuFC45KYbbC/mi
 yl+160BIkBD/4xnRfsJEiO3MD77ctwZLfLk3AjPbqzkmV/JY4zQq6PGEmwWIVPgazWP13G4bJ
 0FoAj8kUlYPSaGBPLlY61ti/hvMUB3lMXCxqADweTdoDdwAVDrfm6urJFXects21gE8x/DGab
 FGyyIDv1ax2/6XRkl3vx8Jk6s8DWCsdrZQskVUAHnQibujB/viwk7KShpKxHPaVFb8nzZ1g6h
 ciGt039KKRo/adyU8rsuMXwbdmR1MqJzekuIG5dIs1NzC3vcPk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

[late reply, I know, sorry about that!]

On Wed, 4 Jul 2018, Paul Smith wrote:

> On Wed, 2018-07-04 at 13:26 +0200, Johannes Schindelin wrote:
> > On Wed, 4 Jul 2018, Paul Smith wrote:
> > 
> > > One thing I wanted to do was provide a default ca-bundle.crt file
> > > along with my local build of Git.  I need my installation to be
> > > relocatable and I'm using RUNTIME_PREFIX with Git 2.18.0 (on
> > > GNU/Linux).
> > 
> > Understandable. We do this all the time in Git for Windows. Our
> > config entry has this form:
> > 
> >         [http]
> >                 sslCAinfo = /ssl/certs/ca-bundle.crt
> > 
> > and in the RUNTIME_PREFIX mode, this will be made relative to the
> > runtime prefix. It is my understanding that bf9acba (http: treat
> > config options sslCAPath and sslCAInfo as paths, 2015-11-23) makes
> > this work.
> 
> Hm.  Unless I'm missing something this doesn't happen (and indeed, it
> does not work for me; with:
> 
>   [http]
>       sslcainfo = /etc/ca-bundle.crt
> 
> I get:
> 
>   fatal: unable to access 'https://github.com/myrepo.git/': error
> setting certificate verify locations:
>     CAfile: /etc/ca-bundle.crt
>     CApath: none
> 
> although it works if I use a fully-qualified pathname, and using strace
> I find the process never attempted to access any other path for ca-
> bundle.crt).
> 
> In http.c we see how this path is treated in http_options():
> 
>         if (!strcmp("http.sslcainfo", var))
>                 return git_config_pathname(&ssl_cainfo, var, value);
> 
> I can't tell exactly how this function is invoked, but the result
> (ssl_cainfo) is used here without further modification:
> 
>         curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> 
> In config.c we find get_config_pathname() which does this:
> 
>         *dest = expand_user_path(value, 0);
> 
> In path.c we find expand_user_path() which does this:
> 
>         if (path == NULL)
>                 goto return_null;
>         if (path[0] == '~') {
>             ...
>         }
>         strbuf_addstr(&user_path, to_copy);
>         return strbuf_detach(&user_path, NULL);
> 
> I don't see any reference to system_prefix(), system_path(), etc. which
> would be needed to RUNTIME_PREFIX-ize things.

I finally got around to dig into this, and found out what is
happening: in https://github.com/git/git/blob/v2.19.0/http.c#L295-L296,
the http.sslcainfo setting is handled by calling git_config_pathname(),
which in turn calls expand_user_path() to handle special cases
(https://github.com/git/git/blob/v2.19.0/config.c#L1067-L1075). And it
is this function which has a specific, special handling on Windows
(which, like so many other changes that are waiting patiently for the
slow upstreaming process, has not made it into any *Git* version yet),
see https://github.com/git-for-windows/git/commit/434b76522de1:

@@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)

        if (path == NULL)
		goto return_null;
+#ifdef __MINGW32__
+       if (path[0] == '/')
+               return system_path(path + 1);
+#endif
        if (path[0] == '~') {
                const char *first_slash = strchrnul(path, '/');
                const char *username = path + 1;

This explains why it works on Windows, but not elsewhere...

Now, I could imagine that this special handling makes a ton of sense not
for *Git for Windows*, but rather for RUNTIME_PREFIX.

So maybe we should replace that `__MINGW32__` condition by
`RUNTIME_PREFIX`? What do you think?

Ciao,
Johannes
