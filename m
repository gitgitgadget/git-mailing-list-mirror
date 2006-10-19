From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:24:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610191321090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
 <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
 <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <4536DBB1.6050701@spamcop.net> <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <45375D16.90204@spamcop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 13:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaW1F-0004hA-LQ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWJSLY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 07:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423012AbWJSLY6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:24:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:41440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422889AbWJSLY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:24:57 -0400
Received: (qmail invoked by alias); 19 Oct 2006 11:24:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 19 Oct 2006 13:24:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Charles Duffy <cduffy@spamcop.net>
In-Reply-To: <45375D16.90204@spamcop.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29340>

Hi,

On Thu, 19 Oct 2006, Charles Duffy wrote:

> Johannes Schindelin wrote:
> > > I presume that for this reason you will also never, _never_ use a
> > > non-mainline branch of git -- even if its actual code only touches UI
> > > enhancements or something similarly non-core
> > >     
> > 
> > NO! The point was that I will not gladly run anything which could change the
> > core. If I know it touches only the UI, there is no problem.
> >   
> 
> If you're willing to look at the source of a branch to know that it 
> touches only the UI, why would you not be willing to look at the source 
> of a plugin to do the same thing?

That is why I said I'd be gladly using a shell-script using git-core 
programs. It is typically no more than 20 lines, and I can review that 
quite easily.

> Shell scripts allow for a fragile system because they could include C code
> snippets which they then compile and LD_PRELOAD.

Well, I do not expect people to misbehave. You do not compile a nasty 
C-program from a shell script _by mistake_.

I also expect people not to constantly miss my point. It could be that I 
am not as proficient in the English language as I thought. In that case, 
I'll better shut up.

Ciao,
Dscho
