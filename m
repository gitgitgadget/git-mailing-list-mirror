From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 11:28:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911291121300.4985@pacific.mpi-cbg.de>
References: <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <20091127095914.GA4865@sigill.intra.peff.net> <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302> <20091127180235.GA26633@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302> <20091127210530.GC26921@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 11:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEgxF-0007vt-B3
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 11:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbZK2KYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 05:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbZK2KYN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 05:24:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:47234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751956AbZK2KYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 05:24:12 -0500
Received: (qmail invoked by alias); 29 Nov 2009 10:24:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 29 Nov 2009 11:24:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+u66BopD6urxzKjKFIHBNXwN9edgzbAN7w7O5yNp
	FZ0bHTI/FcJsLn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091127210530.GC26921@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134009>

Hi,

On Fri, 27 Nov 2009, Jeff King wrote:

> On Fri, Nov 27, 2009 at 09:07:51PM +0100, Johannes Schindelin wrote:
> 
> > > Yes, as a matter of fact, I do work on 10 different computers. I'm sorry 
> > > that you find managing your configuration so challenging. But if you 
> > > don't use the configuration variable, then your own personal setup is 
> > > totally irrelevant.
> > 
> > As I just demonstrated, this is a false statement.
> 
> I must have missed where you demonstrated it.

Usually, my mails are minimal, and I do not write as many mails as I 
used to anymore, so it is hard to miss what I am saying.

For your benefit: both Junio and me talked about experts helping users.  
Even if I do not use the config options, I am affected.  And it does hurt.

> > > If your argument is that this lack of consistency will irritate users,
> > > you need to show that:
> > > 
> > >   1. There are users who switch between a large number of setups, but
> > >      will not apply config consistently.
> > 
> > This is a strawman, and you should be ashamed to put it here.  Just 
> 
> How is this a strawman?

You are comparing config settings which must be different, because they 
affect _what_ project you are working with, with config settings that 
affect _how_ you can work with them.

> When the number of "git grep" crash fatalities rises above zero, maybe 
> this line of reasoning will be relevant.

Sure.  Let's wait for the first crash fatality, and only react then.  No 
need to think ahead.

That's it.  I don't think that I want to participate in this kind of 
discussion anymore,
Dscho
