From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to
	start
Date: Thu, 18 Oct 2007 01:01:58 -0400
Message-ID: <20071018050158.GA11903@coredump.intra.peff.net>
References: <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: koreth@midwinter.com
X-From: git-owner@vger.kernel.org Thu Oct 18 07:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNWS-0001Pd-Lu
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbXJRFCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbXJRFCD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:02:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2344 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbXJRFCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:02:01 -0400
Received: (qmail 32506 invoked by uid 111); 18 Oct 2007 05:01:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 01:01:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 01:01:58 -0400
Content-Disposition: inline
In-Reply-To: <20071018044143.GA24043@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61473>

On Wed, Oct 17, 2007 at 09:41:43PM -0700, koreth@midwinter.com wrote:

> And as an added bonus, we can tell people how to turn off automatic GC
> and how to invoke it by hand.

I like it, especially with the new progress patches.

-Peff
