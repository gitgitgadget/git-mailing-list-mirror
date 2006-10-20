From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 17:39:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201736440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <aaron.bentley@utoronto.ca> <ehaojp$2qv$2@sea.gmane.org>
 <Pine.LNX.4.63.0610201715040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <200610201728.13327.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 17:39:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GawT0-0004Zr-EB
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 17:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946436AbWJTPjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992553AbWJTPjW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 11:39:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:34474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946436AbWJTPjV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 11:39:21 -0400
Received: (qmail invoked by alias); 20 Oct 2006 15:39:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 20 Oct 2006 17:39:20 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201728.13327.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29494>

Hi,

On Fri, 20 Oct 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Fri, 20 Oct 2006, Jakub Narebski wrote:
> > 
> >> Christian MICHON wrote:
> >> 
> >>> - git is the fastest scm around
> >> 
> >> Mercurial also claims that.
> > 
> > Funny. When you type in "mercurial" and "benchmark" into Google, the 
> > _first_ hit is into "git Archives: Mercurial 0.4b vs git patchbomb 
> > benchmark". Performed by the good Mercurial people.
> > 
> > Leaving git as winner.
>  
> Check out http://git.or.cz/gitwiki/GitBenchmarks section "Quilt import 
> comparison of Git and Mercurial" for the latest (OLS2006) benchmark
> by Mercurial.

Thanks for the hint!

BTW the tests in Clone/status/pull make sense, especially the "4 times 
slower on pull/merge". In my tests, merge-recur (the default merge 
strategy, which was written in Python, and is now in C) was substantially 
faster.

> Probably not indexed by Google, or doesn't have high pagerank because it 
> is in PDF and fairly new (therefore has low "citations" number).

I hope these posts boost the pagerank.

Ciao,
Dscho
