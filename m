From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 18:13:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241811330.9925@racer>
References: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org> <20080624053504.GB19224@sigill.intra.peff.net> <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBC7l-0003eD-HY
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYFXRPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbYFXRPN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:15:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:54306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbYFXRPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:15:12 -0400
Received: (qmail invoked by alias); 24 Jun 2008 17:15:10 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp050) with SMTP; 24 Jun 2008 19:15:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mw9dtlQbme8ZHE0qCO1VT8X7+VEVgynsfqtEPcB
	LlkUt5FwpY38Cd
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86091>

Hi,

On Tue, 24 Jun 2008, Linus Torvalds wrote:

> On Tue, 24 Jun 2008, Jeff King wrote:
> > 
> > You seem to have a bunch of _other_ problems with parse_options. And 
> > that is fine, but they have nothing whatsoever to do with anything 
> > I've said. So don't "sky wizard" _me_ about those problems. ;P
> 
> I have a _single_ problem I have with parse_options(), namely that it was 
> painful to convert in pieces.

Okay.

I never wanted anything else than having a way to convert the rest of the 
Git programs to parse options.

Of course, my approach was not meant incremental, yours was.

But I never wanted anything as complicated as to merit a 7-mail patch 
series that I have no time to even look at.

> Do you see now?

I do see now.

Sorry,
Dscho
