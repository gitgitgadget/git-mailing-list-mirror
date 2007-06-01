From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] catch asciidoc failures
Date: Fri, 1 Jun 2007 05:43:51 -0400
Message-ID: <20070601094351.GA10037@coredump.intra.peff.net>
References: <11806790373908-git-send-email-slamb@slamb.org> <20070601083621.GB3521@admingilde.org> <20070601091030.GA2215@coredump.intra.peff.net> <20070601093929.GC3521@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Lamb <slamb@slamb.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, jonas.fonseca@gmail.com
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3ft-0005zu-7D
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256AbXFAJny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 05:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757262AbXFAJny
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:43:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4472 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757256AbXFAJnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:43:53 -0400
Received: (qmail 31275 invoked from network); 1 Jun 2007 09:44:01 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jun 2007 09:44:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2007 05:43:51 -0400
Content-Disposition: inline
In-Reply-To: <20070601093929.GC3521@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48862>

On Fri, Jun 01, 2007 at 11:39:29AM +0200, Martin Waitz wrote:

> very nice!
> Does that need any special asciidoc version?

I don't think so, but I'm not an asciidoc expert. Flipping through the
changelog, it looks like '-a' has existed since before 7.0.

-Peff
