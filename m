From: Jeff King <peff@peff.net>
Subject: Re: git info pages
Date: Thu, 21 Jun 2012 02:26:24 -0400
Message-ID: <20120621062624.GC19485@sigill.intra.peff.net>
References: <jrtlok$n11$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shaqe-0000xX-7C
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab2FUG02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:26:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41028
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520Ab2FUG01 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:26:27 -0400
Received: (qmail 2581 invoked by uid 107); 21 Jun 2012 06:26:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Jun 2012 02:26:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2012 02:26:24 -0400
Content-Disposition: inline
In-Reply-To: <jrtlok$n11$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200385>

On Wed, Jun 20, 2012 at 06:18:45PM -0500, Neal Kreitzinger wrote:

> Are there git 'info' pages or some other form of more extensive
> documentation somewhere that I can look at to get more information
> than what the git 'man' pages have?

There are info pages, but they contain the same text as the manpages.
Look in git.git's Documentation/ subtree. There are a few things which
don't make it to manpage format (like user-manual.txt, technical/, and
howto/) but the manpages are generally the most up-to-date and complete
documentation there is.

What are you looking for in particular?

You might also try the free Pro Git if you're looking for more
discussion:

  http://git-scm.com/book

-Peff
