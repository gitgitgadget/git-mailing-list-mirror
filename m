From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: suggested feature: completely expunge a file (or just a delta)
 a la rebase
Date: Thu, 26 Apr 2007 17:17:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704261716140.12006@racer.site>
References: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com> 
 <7virbju17h.fsf@assigned-by-dhcp.cox.net> <3c6c07c20704260750o68b1d296kc30c17e54a593023@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh5ik-0003lm-QD
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 17:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbXDZPRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbXDZPRT
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 11:17:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:57975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964796AbXDZPRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 11:17:19 -0400
Received: (qmail invoked by alias); 26 Apr 2007 15:17:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 26 Apr 2007 17:17:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19a1T97QHZajU9oBv8x0DfrK25BwyoEQyRwH0oMtp
	rmGSWNDAICFWir
X-X-Sender: gene099@racer.site
In-Reply-To: <3c6c07c20704260750o68b1d296kc30c17e54a593023@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45637>

Hi,

On Thu, 26 Apr 2007, Mike Coleman wrote:

> On 4/26/07, Junio C Hamano <junkio@cox.net> wrote:
> > There have been talks about polishing cg-rewritehist into a
> > shape suitable for inclusion in core git.git, now Cogito is not
> > actively developed anymore.
> 
> Ah, that looks like it'd fit the bill.  I may see if it'll still work
> for my simple case.  Thanks for the pointer.
> 
> > I think the first thing to fix is its name "rewritehist", which
> > may technically be correct, feels a bit too ugly ;-)
> 
> Naming is very important.

Maybe git-rewrite-commits?

> I seem to recall hearing (from PE) that one of the early Unix guys was 
> later asked if there was anything they'd change in hindsight.  Their 
> response: they'd spell "creat" with an 'e'.

In related news: there is really no question that bike sheds should be 
painted red. Really.

Ciao,
Dscho
