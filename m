From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 21:07:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
References: <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <20091127095914.GA4865@sigill.intra.peff.net> <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <20091127180235.GA26633@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 21:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE76m-0001n9-B3
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZK0UHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZK0UHs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:07:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:35584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbZK0UHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:07:48 -0500
Received: (qmail invoked by alias); 27 Nov 2009 20:07:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 27 Nov 2009 21:07:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aFRYJV9ga1Wl+iWjPtPb20B7GgEES4bglHS70Cp
	4J9STdkpwvpHoW
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091127180235.GA26633@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133930>

Hi,

On Fri, 27 Nov 2009, Jeff King wrote:

> On Fri, Nov 27, 2009 at 11:53:42AM +0100, Johannes Schindelin wrote:
> 
> > > If only somebody had written a "pager.status" configuration variable,
> > > you could use that. Oh wait. I did. And it shipped in v1.6.0.
> > 
> > And it makes things inconsistent.  That is why I do not use it. 
> 
> Then you can not use this configuration variable, too. Has the existence
> of pager.status, since you do not use it, been a problem for you so far?

No, since none of the people I helped use it.

> > Do you work on 10 different computers?  I do.  And nothing is more 
> > unnerving than the same command producing something different on the 
> > different computers.
> 
> Yes, as a matter of fact, I do work on 10 different computers. I'm sorry 
> that you find managing your configuration so challenging. But if you 
> don't use the configuration variable, then your own personal setup is 
> totally irrelevant.

As I just demonstrated, this is a false statement.

> If your argument is that this lack of consistency will irritate users,
> you need to show that:
> 
>   1. There are users who switch between a large number of setups, but
>      will not apply config consistently.

This is a strawman, and you should be ashamed to put it here.  Just 
because nobody does what you actively encourage does not mean that the 
encouraged procedure is good, or for that matter, helps anybody but you.

Just think about it.  If you plan to change the side cars are supposed to 
drive on, it is not enough to have a nice cozy committee deciding on it in 
some little room somewhere in Wyoming.  Especially not if they decide that 
you can drive on the other side if you put a sticker "I am a right-wing 
driver" on your car.

It is inconsistent, and it is violating the law of the least surprise.

> And the GitTogether had a "users complain about git, and we try to
> listen" session.

Oh, that makes me so happy.  <sarcasm>Soooo happy</sarcasm>.  So it was an 
ivory tower meeting, once again?

Ciao,
Dscho
