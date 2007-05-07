From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 16:24:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071624210.4167@racer.site>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>  <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
  <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>  <463ECEF4.625F3633@eudaptics.com>
 <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
 <463F14FF.F8DF11EB@eudaptics.com> <002801c790ae$d86a1a90$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Mon May 07 16:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl48P-0004Ld-B9
	for gcvg-git@gmane.org; Mon, 07 May 2007 16:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934002AbXEGOYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933999AbXEGOYM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 10:24:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:33182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934002AbXEGOYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 10:24:12 -0400
Received: (qmail invoked by alias); 07 May 2007 14:24:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 07 May 2007 16:24:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ls0dEcQ8lX/Rf4MGa4kmrlblrGWvl5neX3q7uPL
	d+FfGwjz23YzC0
X-X-Sender: gene099@racer.site
In-Reply-To: <002801c790ae$d86a1a90$0200a8c0@AMD2500>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46465>

Hi,

On Mon, 7 May 2007, Aaron Gray wrote:

> > > On 5/7/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> > > > Aaron Gray wrote:
> > > > > What I want is to be able to work in Windows CMD and envoke .sh 
> > > > > scripts by association (unfortunately you have to add the .sh on 
> > > > > the command name though).
> > > >
> > > > I run the mingw port exclusively from CMD without a .sh 
> > > > association. So exclusively that I don't even know whether any 
> > > > other way of using the tools even works. Of course, you have to 
> > > > get used to
> > > 
> > > Is it public available?
> > 
> > gitweb: http://repo.or.cz/w/git/mingw.git
> > clone:  git://repo.or.cz/git/mingw.git
> > 
> > I only have either time to hack on mingw.git or a Windows 
> > installation, but not both at the same time. Therefore, the port is 
> > now a bit falling back (it's still at 1.5.1). I hope to be able to 
> > change this in a few weeks.
> 
> Great I will check this out when I get some time.
> 
> An .sh to c converter would be the best solution. I will be looking into 
> how hard this would be to do.

NACK.

A stupid .sh to c converter will almost certainly result in slow and 
hard-to-debug code.

If you had bothered to check, you'd know that there are ongoing efforts to 
do the ports properly.

Ciao,
Dscho
