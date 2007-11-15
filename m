From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been
 packed.
Date: Thu, 15 Nov 2007 13:10:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711151306470.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
 <7vwssj6hw8.fsf@gitster.siamese.dyndns.org> <473C02F9.4020402@viscovery.net>
 <20071115084934.GN14735@spearce.org> <20071115085259.GA30913@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 13:10:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsdYU-0004Ka-V1
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 13:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbXKOMKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 07:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbXKOMKa
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 07:10:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:57336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbXKOMK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 07:10:29 -0500
Received: (qmail invoked by alias); 15 Nov 2007 12:10:27 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp054) with SMTP; 15 Nov 2007 13:10:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HJXQe7qIHsTpjuJe6NAWR/lJPXuP+fBaRhl6LdV
	CqV4B/5xjyvujH
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071115085259.GA30913@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65112>

Hi,

On Thu, 15 Nov 2007, Jeff King wrote:

> On Thu, Nov 15, 2007 at 03:49:34AM -0500, Shawn O. Pearce wrote:
> 
> > What's this obsession with whitespace in refnames?  Twice in like
> > two days people are talking about whitespace in refnames.
> 
> I even had Junio convinced at one point!
> 
> I am not actually creating such refs, but I think my brain was still 
> fried from the URL encoding discussion, and I was overly paranoid about 
> spaces.

Yeah, I'm really sorry I started that.  It was meant to do good, but did 
bad.  Oh, well.  The road to hell is paved with good intentions.

Ciao,
Dscho
