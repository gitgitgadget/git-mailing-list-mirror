From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] credentials: add "store" helper
Date: Thu, 24 Nov 2011 15:09:26 -0500
Message-ID: <20111124200926.GA30585@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110756.GJ8417@sigill.intra.peff.net>
 <CAPig+cQ_eP0wG=AFB0rt-SueW-XxrFXKYAXr+4PneYC-dciyuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 21:09:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTfby-0006NH-A0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 21:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1KXUJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 15:09:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49757
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1KXUJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 15:09:28 -0500
Received: (qmail 19291 invoked by uid 107); 24 Nov 2011 20:09:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 15:09:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 15:09:26 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQ_eP0wG=AFB0rt-SueW-XxrFXKYAXr+4PneYC-dciyuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185917>

On Thu, Nov 24, 2011 at 09:29:36AM -0500, Eric Sunshine wrote:

> > +When git needs authentication for a particular context URL context,
> 
> "context URL context"?

Thanks. That is what I get for proofreading right before bed. :)

I squashed this and your other typo fix into the appropriate patches.

-Peff
