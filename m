From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Fri, 15 May 2009 18:51:55 +0200
Message-ID: <20090515165155.GA13177@localhost>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <200905141024.17525.jnareb@gmail.com> <20090514145724.GE30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 15 18:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M50dr-0006lT-1j
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZEOQwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 12:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbZEOQwB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:52:01 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:2373 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZEOQwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 12:52:00 -0400
Received: from darc.dyndns.org ([84.154.123.237]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 May 2009 18:51:55 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M50dX-0003TS-Ln; Fri, 15 May 2009 18:51:55 +0200
Content-Disposition: inline
In-Reply-To: <20090514145724.GE30527@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 15 May 2009 16:51:56.0175 (UTC) FILETIME=[74AAD1F0:01C9D57D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119264>

On Thu, May 14, 2009 at 07:57:24AM -0700, Shawn O. Pearce wrote:
> > > Jakub Narebski <jnareb@gmail.com> wrote:
> > > > The current documentation of git protocol is very sparse; the docs
> > > > in Documentation/technical/pack-protocol.txt offer only a sketch of
> > > > exchange.  You can find more, including pkt-line format, a way sideband
> > > > is multiplexed, and how capabilities are negotiated between server and
> > > > client in design document for "smart" HTTP server, for example in
> > > >   Subject: Re: More on git over HTTP POST
> > > >   Message-ID: <20080803025602.GB27465@spearce.org>
> > > >   URL: http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196
[...]
> GMane is dead right now, otherwise I'd try to find the link you
> were more likely talking about.  I think you were right, there may
> have been a much better post in that particular thread.

I believe this is the most recent version:

	http://article.gmane.org/gmane.comp.version-control.git/94313
