From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The 8th airing of the msysGit herald
Date: Mon, 3 Mar 2008 00:54:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803030052450.22527@racer.site>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <m34pbok54h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVyy9-0006Z6-Ce
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 01:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYCCAzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYCCAzP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 19:55:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:35632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751984AbYCCAzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 19:55:14 -0500
Received: (qmail invoked by alias); 03 Mar 2008 00:55:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp013) with SMTP; 03 Mar 2008 01:55:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18V3Dl7WrYViH2aRj3rKDYbY+6XflwwWwgV45feN0
	k1q4cpPfYImp9g
X-X-Sender: gene099@racer.site
In-Reply-To: <m34pbok54h.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75862>

Hi,

On Sun, 2 Mar 2008, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > > 4) What do you hate most in Git? 
> > 
> > The command line options. Sometimes it seems to me all the really cool 
> > actions in git can only be invoked by a mysterious collection of weird 
> > option switches which 1. I've never heard of, 2. are hidden deep down 
> > in long manual pages which make it impossible to distinguish important 
> > options from the unimportant ones, and 3. change very frequently in 
> > new versions. For example, "git rebase -i" is a nice feature, but it 
> > is simply a different action than a one-shot "git rebase". Hence, if 
> > it is supposed to be really used, it should rather be a command such 
> > as "git interactive-rebase". The GUI tools go a long way to hide those 
> > mysterious option collections, but some of the daily workflow steps 
> > are still unavailable in the GUI. Rebase being the most prominent, I 
> > guess.
> 
> It is not that much different. The basis operation is the same;
> I don't think that "rebase -i" differs from "rebase" more than
> "add -i" differs from "add".

Well, first of all, this was a personal view.

And then, I think he _has_ a point.  Our interfaces are not bad, but they 
are not really obvious, either.

If I only were a bit more gifted in interface design...

> > > 6) What was the most frustrating moment when working with Git? 
> > 
> > Finding that "git pull" will create many more merge commits than I 
> > wanted, and that there doesn't seem to be an easy way of running "git 
> > fetch; git rebase" in one command.
> 
> "git pull --rebase", but it is quite new feature.

Yes, it is.  And it is not that easy for our users to find out about what 
new features got into Git, since there are _so many_ new features.

Ciao,
Dscho

