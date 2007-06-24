From: "Dan Chokola" <dan@chokola.com>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 19:40:35 -0400
Message-ID: <61e816970706241640x181038f6s2e41f381af2c785d@mail.gmail.com>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
	 <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
	 <7vlke9ouv8.fsf@assigned-by-dhcp.cox.net>
	 <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 01:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2bhD-0005G1-KT
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbXFXXkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXFXXkg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:40:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:12877 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbXFXXkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 19:40:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1599768wah
        for <git@vger.kernel.org>; Sun, 24 Jun 2007 16:40:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FmZfTr5RNdnZFo6s976HtySJP0cveePzRrPdUHlrSeHzB+oD41XcRbVG+DIHQ9KjlE5L7NhYaPm5o0nE2ck5/m8TqjP/H/Qs//CPN2dQdzXmN7RkzOvnLl776A16k6Nvk/HkrfW5FdVW8pLUDmqRSdlqx9Mz1crMVMdXSnKTEIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Hs/6t+ulrxgUHQXg95+cdv5T4ed283mkUlDGWkGkByd3OR/tvcF8IR6BoGHZNHd6aEaph4g8BsN889RY0Wk6lEABXdT4QAFgKyEKLVqt9+tI/pkRV2N3NEOzLXfxLuy0jZedPiAkgn4xZTXViv85Ndob/bx9LlzAxGXaH63wDbU=
Received: by 10.114.198.1 with SMTP id v1mr4930751waf.1182728435282;
        Sun, 24 Jun 2007 16:40:35 -0700 (PDT)
Received: by 10.114.234.7 with HTTP; Sun, 24 Jun 2007 16:40:35 -0700 (PDT)
In-Reply-To: <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: cf864c4ba6575e06
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50846>

Resent to the mailing list because my crappy mail client defaulted to
HTML. Sorry.
---------- Forwarded message ----------
From: Dan Chokola <dan@chokola.com>
Date: Jun 24, 2007 7:38 PM
Subject: Re: Darcs
To: Junio C Hamano <gitster@pobox.com>
Cc: Martin Langhoff <martin.langhoff@gmail.com>, Linus Torvalds
<torvalds@linux-foundation.org>, Bu Bacoo <bubacoo@gmail.com>,
git@vger.kernel.org

On 6/24/07, Junio C Hamano <gitster@pobox.com> wrote:
>  "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> >> "Academic".
> >
> > OTOH, and from the POV of someone closely following the SCM tools in
> > the last few years (and using almost all of them), darcs was the first
> > usable DSCM in the camp. I am not sure how much of its commandline
> > user interface was borrowed from BK or elsewhere, but darcs was
> > _easy_, where Arch was extremely hard to use.
>
> I second this.  Before I started contributing to git in its
> early weeks, I staged my own changes to my day-job project in
> darcs to trickle them in to the company's central repository (I
> was sufficiently faster than other members of the project and I
> had to pace myself).
>
> It would have been much more difficult for me to grasp the basic
> concepts of how "distributed development" process works, if I
> did not have an exposure to Darcs before I started, especially
> because I never used BK.

This is an interesting thread. My own background with Git is that it's
the first SCM I've ever used. And it comes from XMMS2 being the first
open-source project I ever contributed back to. I joined shortly after
the kernel (and XMMS2 team, likewise) had switched from BitKeeper to
Git. So, as Linus said in his tech talk, "My brain didn't rot from
years of thinking CVS was doing something sane," and now I can't
imagine ever using a centralized SCM.

The interesting thing is that now I'm learning about all the other
distributed SCMs (most of which came before Git) now, after having
learned Git, so my experience is backwards from a lot of you. When I
first started, had I known about something like darcs, I probably
would have loved it much more than git, which was only usable to the
highest-level minds at first. I had to use cogito for almost
everything. But now it's as easy to use as its distributed friends and
so I don't think ease of use is much of an issue for anyone anymore.

What I have noticed is a lot of nitpicking, of which I'm guilty, too.
The issue Linus brought up about Darcs and versioning is not one I
typically see surface in real life. Users usually complain about some
_release_ version or, "I updated last week." The maintainer's reply is
almost always, "Between (release  x.x.x|last week) and now we fixed
that problem, check out the latest source." While it could certainly
get annoying when trying to track down a very specific version, it's
not a make-or-break issue that's going to cause anyone to drop Darcs
and flock to Git.

I also saw another developer become upset about using Git over
Mercurial partly because of the lack of documentation on things like
the pack formats. And my own nitpick is that I would never use
Mercurial because it's slow and in Python (a language I despise). The
truth is there's a huge feature overlap between Git an Mecurial (as
well as Darcs and others) and the fundamental stuff remains constant.
In fact, I managed to clone, update, and diff some changes with
mercurial without ever reading any documentation.

Just thought I'd throw my observations in the ring instead of lurking
on the list. We'll see if any of it is relevant. :)

-Daniel "Puzzles" Chokola
