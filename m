From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 14:45:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221444460.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> 
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> 
 <Pine.LNX.4.64.0710210031130.25221@racer.site>  <471AFD07.4040606@op5.se> 
 <Pine.LNX.4.64.0710212308540.25221@racer.site>  <471C586A.9030900@op5.se>
 <8fe92b430710220526i65ecb862ie1037e9d94d93b83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijxb9-0003v6-R3
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbXJVNp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXJVNp2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:45:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:55147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752487AbXJVNp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:45:27 -0400
Received: (qmail invoked by alias); 22 Oct 2007 13:45:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 22 Oct 2007 15:45:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aXDoFmOPaOGH+yrkkHCSARnM+VN1sOJKyoXVqWJ
	X2PTKGCYVs0tTu
X-X-Sender: gene099@racer.site
In-Reply-To: <8fe92b430710220526i65ecb862ie1037e9d94d93b83@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62005>

Hi,

On Mon, 22 Oct 2007, Jakub Narebski wrote:

> On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
> [...]
> >>>>> On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
> >>>>>
> >>>>>> Maybe we could group commands into more categories?
> 
> > Similarly, it might be helpful to have help topics the gdb way, like
> > "git help patches". It's one of those things that people have come to
> > expect from a software tool, so perhaps we should humor them? Given gits
> > "every help topic is a man-page" idiom, this shouldn't require any real
> > technical effort.
> >
> > Such topics should probably include
> > merge/merges/merging - overview of various ways of putting two lines of
> > development back together
> > patch/patches - how to create, send and apply
> > tags/branches/refs - what they are, why they're good, link to merging
> 
> Very good idea. It is definitely something that can be worked on.
> 
> By the way, what do you think about "spying" version of git, specially
> marked release which gathers statistics of porcelain used, with
> frequency of its use, and git-sendstats command added in this release?

I like Wincent's approach, scanning .bash_history.

Ciao,
Dscho
