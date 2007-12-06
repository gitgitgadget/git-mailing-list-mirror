From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Thu, 6 Dec 2007 12:13:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712061212590.27959@racer.site>
References: <20071203043258.GA16658@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712031052410.27959@racer.site> <20071203173022.GA19219@coredump.intra.peff.net>
 <7vbq97iqxd.fsf@gitster.siamese.dyndns.org> <20071206055200.GA23309@coredump.intra.peff.net>
 <7vaboogwmq.fsf@gitster.siamese.dyndns.org> <20071206063945.GB18698@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 13:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Fcd-0000UH-MX
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 13:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbXLFMOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 07:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbXLFMOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 07:14:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:48251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752254AbXLFMOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 07:14:07 -0500
Received: (qmail invoked by alias); 06 Dec 2007 12:14:05 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 06 Dec 2007 13:14:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PuoVQkGoPNjuyw5GcxsDdoFfLVJpM+4ZRCeH3Sc
	+4WJjDEDvBHF46
X-X-Sender: gene099@racer.site
In-Reply-To: <20071206063945.GB18698@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67277>

Hi,

On Thu, 6 Dec 2007, Jeff King wrote:

> On Wed, Dec 05, 2007 at 10:33:49PM -0800, Junio C Hamano wrote:
> 
> > Making what was string match to regex using the same syntax is a 
> > regression, isn't it?  I do not use :/ very often myself, so I 
> > personally would not mind but people who are used to using :/ may get 
> > upset about the change.  I do not feel strongly enough for changing it 
> > to regex to declare such a change unilaterally.
> 
> Yes, it is a regression, which is why my initial patch was labeled RFC. 
> Nobody commented on that aspect, [...]

I did.  I sent a link to my own version of that patch, thereby displaying 
my agreement with the intent.

Ciao,
Dscho
