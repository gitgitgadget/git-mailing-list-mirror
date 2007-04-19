X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 11:24:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191118050.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 19 Apr 2007 09:25:20 +0000 (UTC)
Cc: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/+xRaso0/n/Uk2yafJ3Lyqqs1qAfk0XvmRda2D3
	smDLVbe5CuptO7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1HeSt7-0006nx-1R for gcvg-git@gmane.org; Thu, 19 Apr 2007
 11:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161469AbXDSJY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 19 Apr 2007
 05:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161477AbXDSJY7
 (ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 05:24:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:40579 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1161469AbXDSJY5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 05:24:57 -0400
Received: (qmail invoked by alias); 19 Apr 2007 09:24:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net
 (mp037) with SMTP; 19 Apr 2007 11:24:55 +0200
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 18 Apr 2007, Linus Torvalds wrote:

> On Wed, 18 Apr 2007, Johannes Schindelin wrote:
> > 
> > On Tue, 17 Apr 2007, Marcin Kasperski wrote:
> > > 
> > > a) Windows are unsupported
> > 
> > Wrong.
> 
> It's a bit more work to set up though, and it has a lot less mindshare, 
> and testing, obviously.

Given the fact that Hannes is working not only _on_, but _with_ it, tells 
me that it works well enough for any Windows user (remember, they are used 
to rebooting their machines several times a day, just to keep them 
running).

> So yes, windows is a step-child. I'd love for it to not be one, and 
> we'll get there, but it's clearly not as supported as the unix side. We 
> still use a fair number of shell scripts (which in turn use unix 
> commands and pipelines).

Of course, the Windows users' "I want, but I don't contribute" mindset 
does not help either.

> We'll get away from it. I think GSoC will help here.

Unfortunately not as much as I hoped for. Since Google slashed our number 
of projects, we could not get funding for a developer who promised to make 
a Windows installer, and to work on the user experience on Windows.

Pity.

> Actually, at this stage, I really think cogito just *complicates* git 
> usage.

Hmm. However, I have to say that cogito serves/d another purpose quite 
well: Look at what came from cogito into git. Loads of useful 
enhancements. So, I really have to point to "at this stage", because that 
sure was not true 18 months ago.

> What _is_ true is that git is simply different from CVS. I don't think 
> it's necessarily harder to understand or use (in fact, I would argue 
> that git is a lot _easier_ to understand), but it is *different*, and it 
> has a ton more capabilities.

I guess that we should not say that Git is complicated. People tend to 
believe that, but it is simply not true. The basic steps are easy. Really 
easy.

But Git does not keep you there.

> So people coming from CVS/SVN have a double shock: they are supposed to 
> learn things that they "know" are hard (because CVS/SVN made them so damn 
> hard - don't tell me that SVN branching is easy, because it is *not* easy. 
> It may be cheaper to create a branch, but it has _all_ the same idiocies 
> that CVS has once it's created).

It is also dog slow.

Ciao,
Dscho
