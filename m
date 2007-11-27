From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 05:15:20 -0500
Message-ID: <20071127101520.GA5208@sigill.intra.peff.net>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net> <20071127094639.GC3571@sigill.intra.peff.net> <figp6f$onj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 11:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwxTp-0001Y0-7j
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758423AbXK0KPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 05:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758424AbXK0KPZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:15:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758320AbXK0KPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:15:23 -0500
Received: (qmail 31208 invoked by uid 111); 27 Nov 2007 10:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 27 Nov 2007 05:15:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2007 05:15:20 -0500
Content-Disposition: inline
In-Reply-To: <figp6f$onj$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66179>

On Tue, Nov 27, 2007 at 10:49:03AM +0100, Jakub Narebski wrote:

> If I remember correctly /bin/sh on Solaris cannot be used because
> of other issues (like $(...) and such).

BTW, your new mail/news gateway solution seems to send two messages. I
got one that was addressed _only_ to me, and then this one came to the
list (and was addressed only to the list). That means that I had to
manually re-add the list when responding to the first one (or just
assume that you responded to me off-list). Personally, I think this is
worse than the previous "send only to the list" behavior because senders
are inevitably going to fail to re-add the list (but then, I was never
as bothered by others not to be cc'd in the first place).

-Peff
