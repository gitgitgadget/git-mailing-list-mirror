From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sat, 1 Nov 2008 23:53:10 -0400
Message-ID: <20081102035310.GA5357@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 04:55:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwU3m-0002ub-JJ
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 04:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYKBDxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 23:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYKBDxN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 23:53:13 -0400
Received: from peff.net ([208.65.91.99]:2747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbYKBDxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 23:53:13 -0400
Received: (qmail 22270 invoked by uid 111); 2 Nov 2008 03:53:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Nov 2008 23:53:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2008 23:53:10 -0400
Content-Disposition: inline
In-Reply-To: <20081031003154.GA5745@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99805>

On Thu, Oct 30, 2008 at 08:31:54PM -0400, Jeff King wrote:

> So think of us as having three "spots": the HEAD (H), the "stage"[1] (S),
> and the working tree (W). And we want commands for moving content

Re-reading this, I realized I forgot to fill in my footnote. But it was
going to be:

 [1] Actually, the term "the stage" is growing on me.

-Peff
