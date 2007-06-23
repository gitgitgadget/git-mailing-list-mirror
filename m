From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: add example to move everything into a
 subdirectory
Date: Sat, 23 Jun 2007 12:03:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706231201440.4059@racer.site>
References: <Pine.LNX.4.64.0706211805010.4059@racer.site>
 <7vwsxv8a1a.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 13:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I23Od-0004d2-AT
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 13:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbXFWLDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 07:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbXFWLDK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 07:03:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:42351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753489AbXFWLDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 07:03:08 -0400
Received: (qmail invoked by alias); 23 Jun 2007 11:03:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 23 Jun 2007 13:03:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bV3p1BkObw3ZWARmldy1qgsc77BAqJLn5ZCvyQD
	KLfjKoTFOBeLNS
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsxv8a1a.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50730>

Hi,

On Fri, 22 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index ffb31d6..297e09e 100644
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -181,6 +181,14 @@
> 
> Keeping your private repository out of sync with me is Ok, but can you 
> fix the filemode when you have chance?  The warning I get every time I 
> apply a patch from you to this file about mode mismatch somewhat annoys 
> me.

I am sorry! I did not even realize that I was _so_ out of sync. ATM AFAICT 
there is only the "skip" hack in my repo.

Ciao,
Dscho
