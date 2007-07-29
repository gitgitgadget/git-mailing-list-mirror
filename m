From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 08:26:14 -0400
Message-ID: <20070729122614.GA23698@coredump.intra.peff.net>
References: <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org> <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net> <20070729094955.GA14915@coredump.intra.peff.net> <Pine.LNX.4.64.0707291214060.14781@racer.site> <20070729113850.GA17796@coredump.intra.peff.net> <Pine.LNX.4.64.0707291258410.14781@racer.site> <20070729121948.GA21983@coredump.intra.peff.net> <Pine.LNX.4.64.0707291323150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 14:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7qm-00061p-0A
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761841AbXG2M0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761877AbXG2M0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:26:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2978 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761841AbXG2M0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:26:16 -0400
Received: (qmail 28026 invoked from network); 29 Jul 2007 12:26:16 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 12:26:16 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 08:26:14 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707291323150.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54114>

On Sun, Jul 29, 2007 at 01:24:20PM +0100, Johannes Schindelin wrote:

> No.  Just think about "git diff -p -w --quiet".  In some cases it _has_ to 
> recurse.

OK, I'm convinced. It should be as you originally suggested.

-Peff
