From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 23 Nov 2007 13:23:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711231319220.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <20071123103003.GB6754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 14:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvYVw-0007dS-07
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 14:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXKWNXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 08:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbXKWNXw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 08:23:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:56622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752141AbXKWNXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 08:23:51 -0500
Received: (qmail invoked by alias); 23 Nov 2007 13:23:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 23 Nov 2007 14:23:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jXdYPSH9jRVVKMGZ+dhHaB4GXGvxoZd2Q3Paxoe
	WFvv0iLwKGOpt7
X-X-Sender: gene099@racer.site
In-Reply-To: <20071123103003.GB6754@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65898>

Hi,

On Fri, 23 Nov 2007, Jeff King wrote:

> On Fri, Nov 23, 2007 at 12:48:25AM -0800, Junio C Hamano wrote:
> 
> > * jk/send-pack (Tue Nov 20 06:18:01 2007 -0500) 29 commits
> >  + send-pack: cluster ref status reporting
> 
> Did we decide that printing the "maybe you need to pull" hint is not 
> worth doing?

Maybe we could change the (non-fast forward) message into (non-fast 
forward; need to pull?).

Just an idea.

Ciao,
Dscho
