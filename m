From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 03:24:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802030321150.7372@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp> <alpine.LSU.1.00.0802030210240.7372@racer.site> <877ihmivav.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sun Feb 03 04:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLVUN-0006md-5j
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 04:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762394AbYBCDY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 22:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754300AbYBCDY4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 22:24:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:50355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753876AbYBCDY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 22:24:56 -0500
Received: (qmail invoked by alias); 03 Feb 2008 03:24:54 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp023) with SMTP; 03 Feb 2008 04:24:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0214dHVj0B1n168FS9kSZwsYLDV7Im/qGW4c1XS
	QsY/cWPELvxHmN
X-X-Sender: gene099@racer.site
In-Reply-To: <877ihmivav.dancerj%dancer@netfort.gr.jp>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72322>

Hi,

On Sun, 3 Feb 2008, Junichi Uekawa wrote:

> Hi,
> 

Who said that:

> > That woul be surprising.  Git was not invented until early April 2005.  
> > At the moment I still wait (impatiently, because then my current 
> > contract ends) for April 2008.

Please realize that you make it hard on _everybody else_ than you to 
follow who said what by egoistically deleting things that are important.  
Such as who said what.

> > The important thing to realise is that time is such a wonderful 
> > dimension to be exposed to: not only do you live (experience things 
> > that you did not know before), but also other people live and learn.
> > 
> > IOW even Linus realised that the git-xxx format is not _that_ good.  
> > Which is why -- as you should have realised if you did not subscribe 5 
> > minutes ago -- we do not recommend git-xxx at all, but insist on "git 
> > xxx".
> 
> I didn't realize that.
> 
> Git doesn't give any warnings, and manpages give the dashed examples 
> only.
> 
> Although I was subscribed to git-list from day 1, I must admit that 
> these days I don't read this list too closely (hence being caught in 
> surprise at this point).
> 
> I assume things started with the following commit; but really, can we 
> please start with some deprecation notice before really moving it around 
> in user-visible location.

That deprecation notice was the one you originally replied to.  So your 
request has been granted before you even asked for it.

But I suspect that you did not understand what I said: if you install a 
git script (that is not part of the "official" Git), it will probably be 
in the PATH, and you will not have a problem.

Hth,
Dscho
