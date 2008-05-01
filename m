From: Jeff King <peff@peff.net>
Subject: Re: reflog/show question
Date: Thu, 1 May 2008 09:53:54 -0400
Message-ID: <20080501135354.GB10135@sigill.intra.peff.net>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com> <20080428092410.GD16153@sigill.intra.peff.net> <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com> <20080429201214.GB20509@sigill.intra.peff.net> <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com> <20080429230715.GB22598@sigill.intra.peff.net> <93c3eada0804291712u19c1047bl6d44df4ca025bb4d@mail.gmail.com> <93c3eada0804291726l454ccbbv96217d6657d79ded@mail.gmail.com> <93c3eada0804301715r724e8b8xf0ed64ebe016beea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 15:54:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrZFC-0001Ju-0D
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 15:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbYEANxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 09:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYEANxz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 09:53:55 -0400
Received: from peff.net ([208.65.91.99]:2594 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347AbYEANxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 09:53:54 -0400
Received: (qmail 8026 invoked by uid 111); 1 May 2008 13:53:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 09:53:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 09:53:54 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0804301715r724e8b8xf0ed64ebe016beea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80911>

On Thu, May 01, 2008 at 09:45:40AM +0930, Geoff Russell wrote:

> N.B. This problem has vanished -- which means its probably something I
> messed up. I haven't worked out what yet, but I will.  Apologies for
> any time wasted.

Vanished randomly, or after you upgraded to the latest master? Did you
miss the "fix reflog approxidate parsing bug" patch I posted?

-Peff
