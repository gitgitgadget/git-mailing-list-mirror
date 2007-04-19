From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 14:33:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191428360.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> 
 <20070417104520.GB4946@moonlight.home>  <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
  <200704171818.28256.andyparkins@gmail.com>  <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>  <Pine.LNX.4.64.0704181130150.12094@racer.site>
  <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <1176984945.30690.30.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Marcin Kasperski <Marcin.Kasperski@softax.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVpR-0001Xk-9k
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031224AbXDSMde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031231AbXDSMde
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:33:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:60892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031224AbXDSMdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:33:33 -0400
Received: (qmail invoked by alias); 19 Apr 2007 12:33:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 19 Apr 2007 14:33:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2ya0SK7u21fWmD0vMNUj6dbCU4ALbn9xgJsxLKu
	BDqRudV9yVlpZv
X-X-Sender: gene099@racer.site
In-Reply-To: <1176984945.30690.30.camel@cauchy.softax.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45009>

Hi,

On Thu, 19 Apr 2007, Marcin Kasperski wrote:

[BTW: who said the following? You skipped that information.]

> > So I don't think it's even true that new people should be pointed at cg 
> > any more.
> 
> Google points to git.or.cz ;-)

How does Google point to something? You mean the last time you ran the 
search, the top find _for you_ was git.or.cz?

> > But compare setting up a git repository with setting up a CVS 
> > repository. With git, it's literally "git init", and you're done. No 
> > need to worry about CVSROOT issues etc. Everything is self-contained. 
> > CVS is *hard* to get into, by comparison.
> 
> I am in no way advocating CVS, but to be fair in such comparison, one
> should mention also effort of *publishing* git repository and making it
> available to remote clients. Initialized and configured CVS (or
> subversion, or perforce, or ...) repo is something ready to be used by
> remote clients.

No. Not at all. It took me _one day_ to publish my first CVS repository. 
It took me exactly 10 seconds to do that with Git.

If you are referring to readily-usable CVS services like sourceforge's, 
you are comparing apples with sentences.

> Getting correct ssh keys in correct places is - for instance -
> noticeable problem for many people. Especially if they use clients
> (like plink) which natively use alternative key save format. Etc...

I fail to see how you need ssh keys in order to publish a Git repository.

> I agree that git introduces plenty of excellent concepts. What it needs
> is better docs (also, clearly known **SINGLE** master doc, just sth like
> subversion book),

Does that mean you are volunteering?

> cleaned command line interface (I feel that there are
> just too many lowlevel commands visible for beginning user, maybe at
> least one could split them into git-* for mere mortals and gitadm-* for
> repository hackers),

Does that mean we can expect patches from you?

> portability,

Which platform are you having in mind?

> and finally GUI.

Does that mean you will provide patches? A good starting point is git-gui, 
IMHO.

Ciao,
Dscho
