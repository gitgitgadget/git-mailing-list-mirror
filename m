From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Subversion developer: svn is for dumb people
Date: Fri, 19 Oct 2007 15:17:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191514190.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <47176CE0.7030609@midwinter.com> <20071019113447.GC4404@artemis.corp>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148944103-357464387-1192799825=:16728"
Cc: Steven Grimm <koreth@midwinter.com>, 'git' <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iirj7-0005ZH-W7
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbXJSNRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbXJSNRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:17:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:42391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753021AbXJSNRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:17:08 -0400
Received: (qmail invoked by alias); 19 Oct 2007 13:17:06 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp001) with SMTP; 19 Oct 2007 15:17:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+F8bYA2Z+FKdFeu0aFlamKlr/2ARcTdpW3M6not1
	UNL6WmP4HNBHJo
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071019113447.GC4404@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61703>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148944103-357464387-1192799825=:16728
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 19 Oct 2007, Pierre Habouzit wrote:

> On Thu, Oct 18, 2007 at 02:25:36PM +0000, Steven Grimm wrote:
> > Thought folks here might get a kick out of this:
> > 
> > http://blog.red-bean.com/sussman/?p=79
> > 
> > Okay, my summary is slightly facetious, but that's basically the gist 
> > of what he's saying: you should choose Subversion rather than a DVCS 
> > because most of your users won't be smart enough to use the better 
> > tool.
> > 
> > I can't say he's completely wrong, especially about the 20/80% idea 
> > (though I think "20%" is generous), but some of his specific arguments 
> > about DVCS are on the bogus side. "Centralized systems encourage code 
> > reviews," for one -- I challenge him to find a project with a more 
> > pervasive and effective code-reviewing culture than the git project.
> 
>   Your argument is also bogus.
> 
>   IMNSHO, peer reviewing has nothing to do with git, svn, or $SCM. It's 
> a social pattern. There are people that do it because they understand 
> it's a good and necessary sound thing to do, and there are the others. 
> Guess what, it has a lot to do with the 20%/80% line (that I would have 
> more described as the 2/98 but well…).

I tend to disagree.  Git at least _enables_ you to have the 
one-committer-per-repository scheme, it even _encourages_ it to a certain 
extent.

And once you go that route, it is easy to see that the committer says "I 
will not let that _crap_ enter my repository."  Bingo, peer review.

Compare that to a centralised repository, where more often than not, the 
administrator is not even part of the developer community!  It is much 
easier not to feel too responsible for the code you are committing there.

Ciao,
Dscho

---1148944103-357464387-1192799825=:16728--
