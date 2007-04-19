From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 14:28:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191423130.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> 
 <20070417104520.GB4946@moonlight.home>  <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
  <200704171818.28256.andyparkins@gmail.com>  <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>  <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <1176984208.30690.18.camel@cauchy.softax.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marcin Kasperski <Marcin.Kasperski@softax.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVkX-0007eg-E0
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031221AbXDSM2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031231AbXDSM2a
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:28:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031221AbXDSM23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:28:29 -0400
Received: (qmail invoked by alias); 19 Apr 2007 12:28:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 19 Apr 2007 14:28:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o524+hufov3yjSnM02j2IRKk3rCi1E3QyJz+gOo
	1+UgwXAruQr8h3
X-X-Sender: gene099@racer.site
In-Reply-To: <1176984208.30690.18.camel@cauchy.softax.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45008>

Hi Marcin,

[re-Cc:ing list]

On Thu, 19 Apr 2007, Marcin Kasperski wrote:

> 
> > > a) Windows are unsupported
> > 
> > Wrong.
> 
> He he, I even downloaded minGW version, just to find that git-pull is 
> bash script...

So what? Do you think a Python program is a native Windows application?

> > > b) Learning curve is too steep. Unclear relationship git-vs-cogito 
> > > makes it even worse.
> > 
> > Not so wrong. But then, it is clear that git is git is git. If you 
> > find it too complicated, soon enough somebody says "use cogito 
> > instead" and you'll find out about that.
> 
> As I already said: cogito at the moment does not make life easier, but 
> only confuses. Also, we talked about windows in previous sentence, 
> cogito is a bunch of shell scripts...

Again, so what?

> > I mean, you can do with CVS, SVN, HG, etc. almost the same as with 
> > Git. But with Git, I find it faster and easier. BTW much of that does 
> > come from the scriptable nature of Git. It _is_ much easier to write a 
> > short and simple script than to work on a plugin.
> 
> That's double edged sword. The more useful shell scripts, the more 
> unportable tool.

Wrong.

Wrong, wrong, wrong. Shell runs on more machines than Python, for example. 
And if you do not use things like bash arrays, scripts are _perfectly_ 
portable.

It's the same as with HTML. If you really want to make life hard on users, 
you can make it unportable. Alas, that's what most web designers in their 
infinite wisdom do.

Besides, it is not the length of a shell script which makes it unportable. 
For example, some aspects of cogito scripts prevented me from using it. So 
much that I gave up on it.

There are other reasons to prefer C over shell, performance comes to mind.

Ciao,
Dscho
