From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to start
Date: Thu, 18 Oct 2007 01:11:27 -0400
Message-ID: <20071018051127.GE14735@spearce.org>
References: <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <20071018050158.GA11903@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: koreth@midwinter.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNfp-0002Wh-SV
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765466AbXJRFLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765408AbXJRFLh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:11:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51126 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765352AbXJRFLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:11:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNfJ-00068V-6s; Thu, 18 Oct 2007 01:11:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3F37020FBAE; Thu, 18 Oct 2007 01:11:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071018050158.GA11903@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61476>

Jeff King <peff@peff.net> wrote:
> On Wed, Oct 17, 2007 at 09:41:43PM -0700, koreth@midwinter.com wrote:
> 
> > And as an added bonus, we can tell people how to turn off automatic GC
> > and how to invoke it by hand.
> 
> I like it, especially with the new progress patches.

Me too.  Its in my tree now.  :-)

-- 
Shawn.
