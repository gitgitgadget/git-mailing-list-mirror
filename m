From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 13:11:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181310060.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <7vsl0ve50f.fsf@gitster.siamese.dyndns.org> <72B49AA2-B82F-448D-8401-BE1D03C9DCA9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFr0t-0002JJ-J8
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760174AbYARNLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760097AbYARNLL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:11:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:59636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760094AbYARNLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:11:10 -0500
Received: (qmail invoked by alias); 18 Jan 2008 13:11:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 18 Jan 2008 14:11:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AK1AIO22AP8WZFzD5lM4KNbWRlNDk4ELtTJ9JB7
	7ympyDGvYlbZEw
X-X-Sender: gene099@racer.site
In-Reply-To: <72B49AA2-B82F-448D-8401-BE1D03C9DCA9@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71016>

Hi,

On Fri, 18 Jan 2008, Steffen Prohaska wrote:

> On Jan 18, 2008, at 12:40 PM, Junio C Hamano wrote:
> 
> > Johannes Sixt <j.sixt@viscovery.net> writes:
> > 
> > > BTW, how would you like to have a 40+ patch series presented that 
> > > implements the port to MinGW? Should I send to the ML despite its 
> > > volume?
> > 
> > My gut feeling is that you did your usual great job separating them 
> > into logical chunks and it will be a pleasure to review on the usual 
> > channel, just like the trickle you did earlier.
> > 
> > > The current state of the series is available here: 
> > > http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream
> > 
> > Let me take a look sometime (but I cannot even say when right now).  
> > I might change my mind about the above.
> 
> I have one or two patches that could be added, most notably the gpg/CRLF 
> patch.  Maybe we should discuss them before the whole series is proposed 
> for git.git?  Maybe not; then I'd send my patches to the list after 
> Junio applied your series.

I think it is long enough as it is.  My plan is to look at the 40+ 
patches, and try to find a sensible subgrouping so that they can be sent 
in bite-sized chunks.

Ciao,
Dscho
