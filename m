From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC (take 3)] Git User's Survey 2007
Date: Sat, 4 Aug 2007 01:41:57 -0400
Message-ID: <20070804054157.GN20052@spearce.org>
References: <200707250358.58637.jnareb@gmail.com> <200708040250.55180.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCOt-0007Tr-Jz
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXHDFmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbXHDFmD
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:42:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42946 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbXHDFmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:42:01 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHCOj-0007PU-Pw; Sat, 04 Aug 2007 01:41:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E22520FBAE; Sat,  4 Aug 2007 01:41:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200708040250.55180.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54793>

Jakub Narebski <jnareb@gmail.com> wrote:
> It's been more than a year since last Git User's Survey. It would be
> interesting to find what changed since then. Therefore the idea to
> have another survey.

This is actually a pretty good draft.  I'd say its about ready to
go.  A couple of minor comments:
 
> How you use GIT
> 
>     1. Do you use GIT for work, unpaid projects, or both?
>        work/unpaid projects/both/none(*)
>        (*)I use git to interact with some project I'm interested in

I don't understand the (*) point here.  What's the middle ground
between work and unpaid projects?  Paid projects that aren't work?
Isn't that the definition of work?  Very confused...

>     7. How many different projects do you manage using GIT?
>     8. Which porcelains do you use?
>        (zero or more: multiple choice)
>     -  core-git, cogito, StGIT, pg, guilt, other

I really hope nobody chooses pg.  I haven't supported it in a very
long time.  Might be a good idea to keep it in this survey just to
make sure its 0, then omit it from the next survey.  :-)

> Changes in GIT (since year ago, or since you started using it)
...
>     5. Which of the new features do you use?
>        (zero or more: multiple choice)
>     -  git-gui, bundle, eol conversion, gitattributes,
>        submodules, worktree, release notes, user's manual,
>        reflog, stash, shallow clone, detached HEAD, fast-import,
>        mergetool, interactive rebase, commit template, blame improvements,
>        other (not mentioned here)

Wow.

This community has accomplished a lot since the last survey.
That list covers most of the major items over the past year, if
not all of them.  But I'd never really seen it all written out
in such a concise list; there's so much blood, sweat and tears
in those topics from everyone on (and off) this mailing list.
Reading it now is bringing back a lot of memories for me.

Sorry, I just had a very emotional reaction to seeing how much we
have managed to accomplish in so little time.  Thank you to everyone
who has made this list possible!

> Getting help, staying in touch
> 
>     1. Have you tried to get GIT help from other people?
>     -  yes/no
>     2. If yes, did you get these problems resolved quickly
>        and to your liking?
>     -  yes/no

Possible new item:

  Would commerical (paid) support from a support vendor be of
  interest to you/your organization?

Just kicking the idea out there.  Some of us have talked about
this on and off from time to time, I wonder what our user community
thinks of it.  I think Sam Vilain was suggesting he sell Git support
to my day-job company, so my coworkers could call him and ask him
questions, and he could ask me those same questions on #git, then
mail me a 6-pack of beer[*1*] for my troubles.  :)


[*1*] And sadly I don't drink beer...
 
-- 
Shawn.
