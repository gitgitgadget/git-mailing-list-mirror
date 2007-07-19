From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 12:15:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191213300.14781@racer.site>
References: <11848281302504-git-send-email-aroben@apple.com>
 <200707190848.54655.andyparkins@gmail.com> <Pine.LNX.4.64.0707191058090.14781@racer.site>
 <200707191148.46228.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTyb-0001m0-2H
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbXGSLPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbXGSLPR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:15:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:54405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754058AbXGSLPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:15:15 -0400
Received: (qmail invoked by alias); 19 Jul 2007 11:15:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 19 Jul 2007 13:15:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Q80kfVJ+QF9v/Aracuzr3UvvtjNay6Jj0CGPnFn
	NJ3/x4wLB9FYop
X-X-Sender: gene099@racer.site
In-Reply-To: <200707191148.46228.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52970>

Hi,

On Thu, 19 Jul 2007, Andy Parkins wrote:

> On Thursday 2007 July 19, Johannes Schindelin wrote:
> >
> > On Thu, 19 Jul 2007, Andy Parkins wrote:
> >
> > > Would porcelain.editor be a better name for this variable?
> >
> > From my point of view you can put into "myWonderfulGit.editor".  It 
> > does not matter.
> 
> By that argument, why do we bother with subsections at all.  In fact why 
> not call the variable "xhxhxjjjll.yqlaoospsp"?

No.  I said, and I quote here, "From my point of view".

> They are meant to help the human remembering it.
> 
> > So why not just leave it in "core", also because -- strictly speaking 
> > --
> 
> That's what I said for pager - since it's already there.  However, since 
> the editor isn't already in, it's not a question of _leaving_ it 
> anywhere.  Better that it goes in the right place when it is first 
> introduced.

And how would having "core.pager" but "porcelain.editor" be easier to 
remember?  Nah, not really.

Ciao,
Dscho
