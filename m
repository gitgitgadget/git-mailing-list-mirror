From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 03:05:31 -0400
Message-ID: <20061010070531.GB2413@coredump.intra.peff.net>
References: <20061009205551.GO20017@pasky.or.cz> <20061010062126.46664.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 09:05:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBgI-0002SO-0a
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 09:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWJJHFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 03:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWJJHFe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 03:05:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:49598 "HELO
	peff.net") by vger.kernel.org with SMTP id S965058AbWJJHFd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 03:05:33 -0400
Received: (qmail 23547 invoked from network); 10 Oct 2006 03:05:31 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Oct 2006 03:05:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2006 03:05:31 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061010062126.46664.qmail@web31810.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28613>

On Mon, Oct 09, 2006 at 11:21:26PM -0700, Luben Tuikov wrote:

> Anyone can come up with any "statistic" to convince anyone of
> anything.  It's the American way! (to financial success)

Petr introduced quantitative evidence and an analysis. You can argue
that his numbers or his analysis are incorrect, but berating statistics
as a whole is not a compelling argument.

> Anyway, the "confused" link clearly says "blame".  I'm not sure why
> your people were trying to think and figure it out, as opposed to
> simply clicking on the file name itself.  It is the most intuitive
> thing to do as I mentioned in my previous email.

Is it? I think the point of Petr's data is to show that, for whatever
reason, people are NOT intuitively doing as you expect.

> Did you do any demographics on your clickers?  What is their background?

Aren't they, by definition, gitweb users? And isn't that the target
demographic?  You can argue that there are potential gitweb users who
will behave completely differently, but I haven't seen any evidence to
support that claim.

> I can hardly accept this "statistic" as a proof to "reintroduce
> the redundant links".

It's not a proof. It's evidence in support of a claim. Sorry, but this
isn't math.

-Peff
