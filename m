From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 13:49:45 -0400
Message-ID: <20070804174945.GA17113@sigill.intra.peff.net>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org> <20070804071131.GA6557@coredump.intra.peff.net> <alpine.LFD.0.999.0708040928350.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	V?in? J?rvel? <v@pp.inet.fi>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNlB-0005DC-LF
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764914AbXHDRtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764893AbXHDRtu
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:49:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1039 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764844AbXHDRtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:49:49 -0400
Received: (qmail 1147 invoked from network); 4 Aug 2007 17:49:52 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Aug 2007 17:49:52 -0000
Received: (qmail 17307 invoked by uid 1000); 4 Aug 2007 17:49:45 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708040928350.5037@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54889>

On Sat, Aug 04, 2007 at 09:37:17AM -0700, Linus Torvalds wrote:

> > Your mailer claims this message is in us-ascii, but I think it isn't...
> 
> Actually, the email claims it was iso-latin1, at least here. Which the 
> *body* of the email apparently really was.

I think something is munging along the way for at least one of us. My
copy of the mail clearly says:

  Content-type: text/plain; charset=us-ascii

and it has been through nothing between vger and my disk except qmail
(and there tends to be no munging there, since qmail accepts 8bit smtp).

The "from" header, on the other hand, is encoded in rfc2047-style
iso-8859-1.

-Peff
