From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 13:32:17 -0500
Message-ID: <20091129183217.GB21520@sigill.intra.peff.net>
References: <20091125222037.GA2861@coredump.intra.peff.net>
 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
 <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
 <20091127180235.GA26633@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
 <20091127210530.GC26921@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911291121300.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 29 19:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEoZV-0004QP-Oh
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 19:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbZK2ScO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 13:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZK2ScN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 13:32:13 -0500
Received: from peff.net ([208.65.91.99]:41704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbZK2ScN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 13:32:13 -0500
Received: (qmail 7715 invoked by uid 107); 29 Nov 2009 18:36:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 29 Nov 2009 13:36:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Nov 2009 13:32:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911291121300.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134031>

On Sun, Nov 29, 2009 at 11:28:27AM +0100, Johannes Schindelin wrote:

> > > > Yes, as a matter of fact, I do work on 10 different computers. I'm sorry 
> > > > that you find managing your configuration so challenging. But if you 
> > > > don't use the configuration variable, then your own personal setup is 
> > > > totally irrelevant.
> > > 
> > > As I just demonstrated, this is a false statement.
> > 
> > I must have missed where you demonstrated it.
> 
> Usually, my mails are minimal, and I do not write as many mails as I 
> used to anymore, so it is hard to miss what I am saying.
> 
> For your benefit: both Junio and me talked about experts helping users.  
> Even if I do not use the config options, I am affected.  And it does hurt.

A point which I adressed in my numbered point (2) in the mail you are
quoting above. But you didn't bother to quote that part.

> > When the number of "git grep" crash fatalities rises above zero, maybe 
> > this line of reasoning will be relevant.
> 
> Sure.  Let's wait for the first crash fatality, and only react then.  No 
> need to think ahead.

You missed my point. My point is that your analogy had many
characteristics that do not apply to this situation. You are comparing a
situation where somebody's preference (to drive on the left side or the
right side) is weighed against a system where everyone needs to follow
the same rule, or people will die in large numbers. The actual situation
at hand is a git grep configuration variable. I am weighing the
preference of people who use git every day and want it to work in a
certain way against the possibility that somebody helping them will be
slightly inconvenienced or surprised. Something that will happen much
less frequently than the person actually _using_ git, and something
which has much smaller negative consequences than people dying.

> That's it.  I don't think that I want to participate in this kind of 
> discussion anymore,

Fine. I have made my point over and over, and not once have you
responded to it directly, so I also feel this is going nowhere.

-Peff
