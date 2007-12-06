From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git guidance
Date: Thu, 6 Dec 2007 21:22:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712062119090.21625@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
 <200712072035.47359.a1426z@gawab.com> <47583E57.9050208@op5.se>
 <200712072155.04643.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 21:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0NF7-0001z1-7I
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 21:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXLFUWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXLFUWX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 15:22:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:36175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751490AbXLFUWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 15:22:22 -0500
Received: (qmail invoked by alias); 06 Dec 2007 20:22:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp038) with SMTP; 06 Dec 2007 21:22:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cyhoPC9ec6nuRUbjMWVClQSSTI5NHK27IfebMnJ
	X9itHd8JzOmRnt
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <200712072155.04643.a1426z@gawab.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67334>

Hi,

On Fri, 7 Dec 2007, Al Boldi wrote:

> Andreas Ericsson wrote:
> > Al Boldi wrote:
> >
> > > By pulling the sources into a git-client manager mounted on some 
> > > dir, it should be possible to let the developer work 
> > > naturally/transparently in a readable/writeable manner, and only 
> > > require his input when reverting locally or committing to the 
> > > server/repository.
> >
> > How is that different from what every SCM, including git, is doing 
> > today? The user needs to tell the scm when it's time to take a 
> > snapshot of the current state. Git is distributed though, so 
> > committing is usually not the same as publishing. Is that lack of a 
> > single command to commit and publish what's nagging you? If it's not, 
> > I completely fail to see what you're getting at, unless you've only 
> > ever looked at repositories without a worktree attached, or you think 
> > that git should work like an editor's "undo" functionality, which 
> > would be quite insane.
> 
> You need to re-read the thread.

I don't know why you write that, and then say thanks.  Clearly, what you 
wrote originally, and what Andreas pointed out, were quite obvious 
indicators that git already does what you suggest.

You _do_ work "transparently" (whatever you understand by that overused 
term) in the working directory, unimpeded by git.

And whenever it is time to revert or commit, you cry for help, invoking 
git.

So either you succeeded in making yourself misunderstood, or Andreas had 
quite the obvious and correct comment for you.

Not that diffcult,
Dscho
