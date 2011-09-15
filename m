From: Joshua Stoutenburg <jehoshua02@gmail.com>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 02:42:45 -0700
Message-ID: <CAOZxsTrxPZ1V+_W=trRpOTJ9emh8msreGOyAYm_1hs0zXaOd1w@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	<4E71A5FF.5040807@viscovery.net>
	<201109150948.09040.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 11:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R48T8-0002Eo-3V
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 11:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318Ab1IOJmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 05:42:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44162 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab1IOJms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 05:42:48 -0400
Received: by eya28 with SMTP id 28so225330eya.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=g7SEMwbza4rTWqw5bRUx/e+da9gebVWETv4mgf2mYCI=;
        b=lmy1zI3Rebzuqbb63Hv/x1EhOttD2B6s8BStOMvMriLyX5a7KCYFv2AQWKGqgZuXSl
         juMqg6uFqcHzkaHjhsWC31OsUE0DVxmdslUO7frhKdlOjZbbHq2B6DckrKs9FFrRZzak
         G/fwn1iY/QhhYdcp6ZBGhbs5RmcpffR++k/K0=
Received: by 10.213.26.135 with SMTP id e7mr320936ebc.129.1316079765651; Thu,
 15 Sep 2011 02:42:45 -0700 (PDT)
Received: by 10.213.16.195 with HTTP; Thu, 15 Sep 2011 02:42:45 -0700 (PDT)
In-Reply-To: <201109150948.09040.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181451>

On Thu, Sep 15, 2011 at 12:48 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> Johannes Sixt wrote:
>> Even when you want to exchange your commits between two or three mac=
hines,
>> all you need is ssh access. There is no *git server* necessary. git =
is not
>> svn. ;-)
>
> I'd even put this somewhat more bluntly. =A0My two-step advice on
> switching from svn to git is:
>
> 1) forget *everything* you know from SVN
> 2) learn git as usual
>
> I don't hang out on IRC as much any more, so maybe it got better. =A0=
But
> 90%[*] of SVN convert's problems seem to stem from some preconceived
> notions they carried over from SVN.
>
> Such as, "HEAD is the newest commit". =A0Or the whole centralized
> vs. distributed you mentioned.
>
>
>
> [*] 78% of all statistics were made up on the spot
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>

How can I "learn git as usual"?

I don't think I was on Subversion long enough to permanently damage my
brain.  Only a few months (actually . . . that's probably enough).  I
never used it's branching, tagging or merging features.  Commit and
revert were the only that I used.  Regardless, I'm happy to forget
everything I know about Subversion.

I've watched Linus Torvalds tech talk on git:
http://www.youtube.com/watch?v=3D4XpnKHJAok8
I also read four and a half chapters of Pro Git pdf:
http://progit.org/ebook/progit.pdf
I read and understood git for computer scientists:
http://eagain.net/articles/git-for-computer-scientists/

So I have a pretty good understanding why git is THE superior source
code management choice.  And I have a basic understanding of how git
works.  I know how to install a *nix server and can survive on the
CLI.

Here's where I think I'm having some troubles, and maybe you can help
me identify any others:

I got confused in Chapter 5 of the Pro Git pdf book, trying to discern
what needs to be done on the server, and what needs to be done on the
work station.  The chapter seems to jump around a bit, and doesn't
follow a linear pattern.  Maybe I need to read it more carefully?

Also, I'm not clear on the best way to manage large numbers of git
users (like 12-24), who also may have permissions to other services as
well (ftp, databases, email, etc).  I have some hesitancy creating
each one manually on the CLI.

=46inally, I'm not sure how to "learn git as usual".  Point me in the
right direction, please.
