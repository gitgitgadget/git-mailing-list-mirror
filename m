From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How it was at GitTogether'08 ?
Date: Sat, 8 Nov 2008 16:31:04 +0100
Message-ID: <200811081631.06229.jnareb@gmail.com>
References: <200811080254.53202.jnareb@gmail.com> <ee77f5c20811072108o21f97c97i8174f4f7ecd67030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 16:32:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kypnf-0006IG-GE
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 16:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYKHPbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 10:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYKHPbQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 10:31:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:34952 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbYKHPbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 10:31:14 -0500
Received: by nf-out-0910.google.com with SMTP id d3so826362nfc.21
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=P1fxZCrRJKTk0SfHzkFcrnu43cLXxhCw2rIW8u4ayaI=;
        b=JWGBsXBPpYrSRrwXbkuEIVNvROYVHhU7ymdU2O3yAyTb2W0Bmtjrsq+u2qPREKj2Ql
         YxbOSongU/qMncUHN0IaL/qVqLcRXleQYPlTBR6etaiNpoBPy3iI2sc2QlnDXxpxk64A
         DU2u7Fnz2iNjaCVXIkrXWCd+POcLBkZtEsPKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BiKx8S09iDsa9XEGFiPpGR07fbKIFqdI0kR9U+2I5uhzSfZfZE4jfH/hJ2XHL6xII2
         KEhQw/+LbyHa7ODrYgYFZcKKroP89L8+JgXW9QKgH5emN4De0mmmNWZryQrLsdsZxFsH
         H3w668ibU23a8XfjJu1SFXHPfAlPQmvTt9ces=
Received: by 10.210.12.18 with SMTP id 18mr5361238ebl.42.1226158272858;
        Sat, 08 Nov 2008 07:31:12 -0800 (PST)
Received: from ?192.168.1.11? (abwx16.neoplus.adsl.tpnet.pl [83.8.247.16])
        by mx.google.com with ESMTPS id 7sm6017704eyb.1.2008.11.08.07.31.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 07:31:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <ee77f5c20811072108o21f97c97i8174f4f7ecd67030@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100408>

On Sat, 8 Nov 2008, David Symonds wrote:
> On Fri, Nov 7, 2008 at 5:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> Here's my thoughts on some of these talks.
> 
> > Mon, Oct 27, 2008
> > -----------------
> > * Dscho: Contributing with Git
> >  http://www.youtube.com/watch?v=j45cs5_nY2k
> 
> It was a good intro, but I was expecting a few more non-GitTogether
> people. We had quite a large room, but there was only about a dozen
> other people who came along. I don't know whether that was the fault
> of the timing, lack of advertising, or a lack of interest.

By the way, it would be nice to have transcript for this talk, just
like there is for Linus talk:
  http://git.or.cz/gitwiki/LinusTalk200705Transcript
(but this would take some doing).
 
It would be also nice to have slides for the talk available somewhere,
just like slides for "Git Chronicle".

> > * Junio: Git Chronicle
> >
> >  blog: Junio went though a sort of statistical history of the Git project
> >  that was fascinating (turns out there are still about 220 lines of code
> >  still around from Linus original first commit).
> 
> This was really interesting. It would be great to put this on a
> general web page instead of in a PDF.

Something like Sam Vilain slides from "perl.git" talk?, 
  http://utsl.gen.nz/talks/perl-history/slides/

It shouldn't be that hard, depending on the original program the slides
were made... well, it was made in Impress from OpenOffice.org 2.4; it
might have export to (X)HTML + images, and to SWF (Flash presentation).

> > * Petr: Renames Again and Again and Again
> >
> >  IRC: detection of wholesame renames of directories (WIP) and '--follow'
> >  limitation were mentioned, but outcome is unclear; pasky plans to hack
> >  together some patch implementing explicit renames hinting
> 
> One thing I didn't get around to bringing up: one of the benefits of
> diff-time rename detection that is often touted is that algorithms can
> improve over time. Do folk here know whether that has actually
> happened recently, in a general way? Do people actually expect major
> improvements in the future?

If I remember correctly there was at least one improvement in rename
detection, namely better talking into account filename similarity score,
so for example similar files moved (or copied) didn't get marked as
coming from one source (and rest deleted).

> > * Tom: GitHub
> >
> >  IRC: a tour, some history, and insight into how it works; some nice
> >  gimmicks, such as "gist" (a git backed pastebin), or like network graphs
> >  (look graphically at forks of a repository).
> >
> >  blog: Tom got to demonstrate GitHub and Gist to the group, most of whom
> >  are very command line oriented and had not used either before.
> 
> The demo of iGitHub (an iPhone app that can act as a clone/push
> target) looked really cool, if it can get further development. It
> could potentially be really handy for travellers who could push to
> their iPhone, and then push from there to an internet server.

iGitHub has nothing to do with GitHub; I think you put the comment in
a wrong place; the iGitHub (or iGit / iGitRouter) was a separate talk
in "Lighting Round Talks" next day.

> > * Scott: Linkable Library
> >
> >  blog: got to talk about the need for a linkable git library
> >
> >  http://thread.gmane.org/gmane.comp.version-control.git/99608
> 
> It's good to see this starting to get wider traction. I think we
> discussed that there could be benefits to git itself, beyond just
> helping other programs access git repositories faster than fork/exec.

What benefits would be those? Current design of "fire and forget",
which stopped libification efforts till now was used for a reason...

> > * Sam: perl.git
> >
> >  blog: Sam demonstrated the work he went through to import 20 years of Perl
> >  history into the git repository that the Perl team is just now finishing
> >  transitioning to from Perforce.
> >
> >  http://utsl.gen.nz/talks/perl-history/slides/
> 
> It was very cool to see old-school email addresses like <isis!aburt>
> in git, handled just fine.

This is not suprising, as Git treats committer and author email data
as opaque data, not analysing it at all (some commits from early
versions of git might not have this data at all, IIRC).
 
> > * Tim: Git as a Media Repository
> >  http://www.thousandparsec.net/~tim/media+git.pdf
> 
> This has kicked off some mailing list discussion; I think this can be
> a major weak point for git, since checking out only a subtree (and
> only the latest revision) is the common SVN way, which copes with
> media repositories and the like just fine.

Well, you can workaround this weakness by (ab)using submodules...
...and one should always remember that casual partial checkouts
interfere a bit with whole-tree commits.

-- 
Jakub Narebski
Poland
