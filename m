From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git weekly news: 2008-49
Date: Fri, 05 Dec 2008 08:02:33 -0800 (PST)
Message-ID: <m3d4g6ipah.fsf@localhost.localdomain>
References: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 17:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8d9o-0000m0-No
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 17:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYLEQCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 11:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbYLEQCi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 11:02:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:37405 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYLEQCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 11:02:36 -0500
Received: by ug-out-1314.google.com with SMTP id 39so36915ugf.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=L1gf+dRmPh5609x5Gcxj4xTvC8KoNHp5fvMcgA+YCDQ=;
        b=m41C9/leGTajdtzMlm3yip3jcAU2r4nfBa3ulpYwku9kH3dLCXe392ofHAVp4UVM7Z
         spsWnjIyRTwKa7Gy7tKkUXsJSheCxPEtf0J8iW+kBZk0GiDHjfQFB/o9TZaCqAjJCpyi
         mrkbIgs2rFlmAMbHkxmHwkjqGAhYGv3SShU3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=YvDSPXgliM/fwDOVh6uVqL7K1Ex0u7JcH5Y2JKnQDfhDVpMZM0FybtNM+OgS5LtpbW
         Jl/R70hTb30Oey8/FDZvpdzElrOY7d5puejByq+55xMzrULJ2EgFmsELF2UvHl8z0b5k
         ZXIoNk/oRHIF1gHCkdPJf2JzqQb+5vX7Urzto=
Received: by 10.86.93.19 with SMTP id q19mr731070fgb.62.1228492954056;
        Fri, 05 Dec 2008 08:02:34 -0800 (PST)
Received: from localhost.localdomain (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id e20sm8748959fga.27.2008.12.05.08.02.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 08:02:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB5G2A14012081;
	Fri, 5 Dec 2008 17:02:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB5G1xUq012076;
	Fri, 5 Dec 2008 17:01:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102403>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> Hi there,
> 
> I've been following the git tag at delicious.com[1] and there's quite
> many interesting links, so I thought  on gathering them so the git
> community can enjoy them in one pack :)

Nice work, although I think better alternative would be to weed those
links out, and put them in appropriate sections (or subsections) on
Git Wiki; to be more exact on http://git.or.cz/gitwiki/GitLinks
 
> The blog post is here:
> http://gitlog.wordpress.com/2008/12/05/git-weekely-news-2008-49/

First, "Official git blog"? Official? There is nothing official about
it. "Unofficial git blog", or "A git developer blog" (or "A git
follower blog"; unfortunately names like gitter or gitster for git
power user's, like TeXnician for TeX users, are taken by nicknames on
#git, if I remember correctly).  Only git maintainer (Junio Hamano)
and git development community (the git mailing list) can decide that
something is "official" resource.

Second, I am a bit curious about 49 in "Git weekly news: 2008-49"
name of the post.

Third, it is collection of links, not news[1].

[1] It would be nice if somebody resurrected GitTraffic, offshot of
now defunct KernelTraffic, or at least helped to write Git articles
for KernelTrap (which currently is in a bit of hiatus).

> 
> But here are the links anyway. The order is rather random.

Moreover the _quality_ of those links is very random.

> Why Git is Better than X
> http://whygitisbetterthanx.com/

Quite good link from what I superficially checked, present in
GitComparison wiki page.

> 
> GitTorrent, The Movie
> http://www.advogato.org/article/994.html

This article is so full of bad information, exaggeration and
hyperbole, that it would be better to forget about it, and not put it
in the list.

> Peer-to-peer Protocol for Synchronizing of Git Repositories
> http://code.google.com/p/gittorrent/

Not news.

> 
> Codebase - Git repository hosting with source browser, changesets,
> ticketing & deployment tracking.
> http://atechmedia.com/codebase

Not news. Besides it is present in GitHosting wiki page.

> 
> Codebase Launches Git-based Project Management Service
> http://www.sitepoint.com/blogs/2008/12/04/codebase-launches-git-based-project-management-service/

Good link, perhaps should be added as 'see also' on GitHosting wiki
page, if it is not there already.

> 
> The Git Community Book
> http://book.git-scm.com/index.html

http://book.git-scm.com/

Good link, present in GitDocumentation. But not news link.

> 
> GitX: A git GUI specifically for Mac OS X
> http://gitx.frim.nl/index.html

On InterfacesFrontendsAndTools. But not a news link.

> 
> Pushing and pulling with Git, part 1
> http://www.gnome.org/~federico/news-2008-11.html#pushing-and-pulling-with-git-1

Very good documentation, with nicely done graphic.

> $ cheat git
> http://cheat.errtheblog.com/s/git/

A bit big for a cheat _sheet_. perhaps it should be added to
GitCheatSheet (see example here for cheat _sheet_) and/or to
GitDocumentation wiki page.

> gh > hg
> http://github.com/blog/218-gh-hg

Seems to be a bit of curio. Not important enough to place it in
GitLinks, IMVHO.

> 
> Easy Git External Dependency Management with Giternal
> http://www.rubyinside.com/giternal-easy-git-external-dependency-management-1322.html

Present on BlogPosts. Might be not as important as article about
Gitosis, because 1.) you can do this by hand, 2.) there are alternate
tools, like Piston, Giston -> Braid.

> Work with Git from Emacs
> http://xtalk.msk.su/~ott/en/writings/emacs-vcs/EmacsGit.html

Very good article, presenting various Emacs modules to work with
Git. Currently as far as I know not present on Git Wiki, but present
on 'Git' page on Emacs Wiki.

> 
> It's Magit! A Emacs mode for Git.
> http://zagadka.vm.bytemark.co.uk/magit/

Probably should be added (as the rest of Emacs modes) to the
InterfacesFrontendsAndTools git wiki page.

> 
> Improving my git workflow
> http://hoth.entp.com/2008/11/10/improving-my-git-workflow

This post is mainly about the same as
  http://graysky.org/2008/12/git-branch-auto-tracking/
namely setting tracking information for _pushed_ branch, using single
command. 

This could have been added to BlogPosts git wiki page.

> 
> git-bz: Bugzilla subcommand for Git
> http://blog.fishsoup.net/2008/11/16/git-bz-bugzilla-subcommand-for-git/

Should be added in addition to git-bugzila to appropriate section at
InterfacesFrontendsAndTools wiki page. Good link.

> 
> android.git.kernel.org Git
> http://android.git.kernel.org/

Is at GitProjects, but thanks for reminding about new server (new
URL). Not a news.

> 
> GitSvnComparsion
> http://git.or.cz/gitwiki/GitSvnComparsion

No comment.

> 
> Guides: Developing with Submodules
> http://github.com/guides/developing-with-submodules

Seems like a good reference. Probably should be added to both
GitSubmodules and BlogPosts pages at git wiki.

> 
> A web-focused Git workflow
> http://joemaller.com/2008/11/25/a-web-focused-git-workflow/

I have't read it in detail, so I don't know if the workflow described
there makes sense. I would probably create some rule in Makefile and
use "make publish" or something, which would push the chages _and_
update page, or use post-update hook for that using some 'git-export'
equivalent.

Otherwise from first glance looks like good resource.

> 
> Why we chose Git, a rebuttal
> http://www.unethicalblogger.com/posts/2008/11/why_we_chose_git_a_rebuttal

Nice reference I think, either for GitComparison or BlogPosts (in the
"Praise" section), or GitLinks.

> Git'n Your Shared Host On
> http://railstips.org/2008/11/24/gitn-your-shared-host-on

Not something that one cannot find in basic git documentation, but in
"Further Reading" it has nice selection of links.

> 
> Git integration with Hudson and Trac
> http://www.unethicalblogger.com/posts/2008/11/git_integration_with_hudson_and_trac

Nice example of post-receive hook. Either for BlogPosts or
InterfacesFrontendsAndTools page.

> Everyday GIT With 20 Commands Or So
> http://www.kernel.org/pub/software/scm/git/docs/everyday.html

No comment.

> 
> Hosting Git repositories, The Easy (and Secure) Way
> http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
Seminal reference, can be found at BlogPosts page on git wiki.
Very good link.

> 
> 10 Reasons to Use Git for Research
> http://mendicantbug.com/2008/11/30/10-reasons-to-use-git-for-research/

Very nice article.

> 
> [1] http://delicious.com/tag/git

I have a host of links to blog posts with git or distributed version
control info bookmarked...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
