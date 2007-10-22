From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: best git practices, was Re: Git User's Survey 2007 unfinished summary
 continued
Date: Mon, 22 Oct 2007 12:04:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221156540.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijv5n-0007rX-PC
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbXJVLEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXJVLEz
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:04:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751651AbXJVLEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:04:54 -0400
Received: (qmail invoked by alias); 22 Oct 2007 11:04:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 22 Oct 2007 13:04:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DhQ14DlADvb861RtjscOAsRGLNn9scS0k5Brq4C
	2SpD0uEAXIFAuq
X-X-Sender: gene099@racer.site
In-Reply-To: <471C586A.9030900@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61986>

Hi,

On Mon, 22 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > I'd really like people to respond not so much with broad and general 
> > statements to my mail (those statements tend to be rather useless to 
> > find how to make git more suitable to newbies), but rather with 
> > concrete top ten lists of what they do daily.
> > 
> > My top ten list:
> > 
> > - git diff
> > - git commit
> > - git status
> > - git fetch
> > - git rebase
> > - git pull
> > - git cherry-pick
> > - git bisect
> > - git push
> > - git add
> > 
> > So again, I'd like people who did _not_ tweak git to their likings to 
> > tell the most common steps they do.  My hope is that we see things 
> > that are good practices, but could use an easier user interface.
> 
> I'm not so sure we'd want to hide commands that git-gurus simply do not 
> use, such as git-blame.

I was not talking about commands that git gurus simply do not use.  I 
explicitely avoided asking "git gurus" for what they use.

> In my opinion, we should just locate the highest level available of UI 
> tool that implements a particular feature and have that listed in the 
> git[- ]<tab> view.

>From the survey it is utterly clear that the available UI tools are still 
not good enough.

So once again, what operations involving git do people use regularly?

<rationale>There is a good chance that git is not optimised for most 
people's daily workflows, as project maintainers seemed to be much more 
forthcoming with patches, and therefore maintainers' tasks are much more 
optimised than in other SCMs.</rationale>

Ciao,
Dscho

P.S.: If nobody replies with actual daily workflows to this mail, I'll 
just assume that this complaint in the user survey was just bullocks, and 
no change in git is needed.
