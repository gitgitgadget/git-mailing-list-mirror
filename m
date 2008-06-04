From: Jeff King <peff@peff.net>
Subject: Re: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 15:16:19 -0400
Message-ID: <20080604191619.GA17327@sigill.intra.peff.net>
References: <20080604183858.GA7095@sigill.intra.peff.net> <7vwsl5vxa5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yTz-0007od-R1
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbYFDTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbYFDTQW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:16:22 -0400
Received: from peff.net ([208.65.91.99]:2632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136AbYFDTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:16:22 -0400
Received: (qmail 20788 invoked by uid 111); 4 Jun 2008 19:16:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 04 Jun 2008 15:16:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2008 15:16:19 -0400
Content-Disposition: inline
In-Reply-To: <7vwsl5vxa5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83812>

On Wed, Jun 04, 2008 at 12:02:26PM -0700, Junio C Hamano wrote:

> And blaming Linus for this is slightly unfair, as the context the original

Right. I didn't mean to blame Linus so much as I had the notion that he
would have some clue that there wasn't something trickier going on.

Maybe I should have said "git annotate told me that..." ;)

-Peff
