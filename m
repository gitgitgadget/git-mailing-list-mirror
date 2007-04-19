From: Theodore Tso <tytso@mit.edu>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 08:45:36 -0400
Message-ID: <20070419124536.GD3513@thunk.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <1176984945.30690.30.camel@cauchy.softax.local> <Pine.LNX.4.64.0704191428360.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcin Kasperski <Marcin.Kasperski@softax.pl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeW1V-0005y6-K0
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S637742AbXDSMpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S637744AbXDSMpr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:45:47 -0400
Received: from thunk.org ([69.25.196.29]:49673 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S637742AbXDSMpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:45:46 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HeW7V-00076P-3Z; Thu, 19 Apr 2007 08:52:17 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HeW12-0002qI-Df; Thu, 19 Apr 2007 08:45:36 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704191428360.8822@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45013>

On Thu, Apr 19, 2007 at 02:33:31PM +0200, Johannes Schindelin wrote:
> > > So I don't think it's even true that new people should be pointed at cg 
> > > any more.
> > 
> > Google points to git.or.cz ;-)
> 
> How does Google point to something? You mean the last time you ran the 
> search, the top find _for you_ was git.or.cz?

I just checked today.  If you go to http://www.google.com, and enter
"git", and then click on "I'm feeling lucky", you will go to
http://git.or.cz.  One of the first links you will then see,
misleading titled in a box labelled, "Git crash courses", are "Git for
CVS users", and "Git for SVN users", and both of these getting started
documents reference cg commands and only cg commands.

So when projects downgrade git as having confusing documentation, and
tutorials that contradict each other about how to do things, this is
very likely one of the reasons why.

							- Ted
