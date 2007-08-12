From: Jeff King <peff@peff.net>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 19:10:28 -0400
Message-ID: <20070812231028.GA17620@sigill.intra.peff.net>
References: <85ir7kq42k.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> <85abswo9gf.fsf@lola.goethe.zz> <20070812200258.GA13298@sigill.intra.peff.net> <85tzr45smb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 01:10:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKMZz-00045e-3F
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 01:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934250AbXHLXKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933666AbXHLXKg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 19:10:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2991 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763328AbXHLXKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 19:10:35 -0400
Received: (qmail 6925 invoked by uid 111); 12 Aug 2007 23:10:42 -0000
X-Spam-Status: No, hits=-1.3 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 12 Aug 2007 19:10:40 -0400
Received: (qmail 17746 invoked by uid 1000); 12 Aug 2007 23:10:28 -0000
Content-Disposition: inline
In-Reply-To: <85tzr45smb.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55734>

On Sun, Aug 12, 2007 at 11:51:24PM +0200, David Kastrup wrote:

> One percent too many before join, and the order of the articles is
> reversed (--reverse helps here).

Sorry, yes, a cut and paste error on the first. For the second, the
order is largely irrelevant if your reader is going to sort them anyway
(and since they are generally all in a single thread, the threading will
define the order).

> So actually Gnus would need some kicking into shape before it actually
> would present a useful tool.  On the positive side, it takes about 15
> seconds sucking up and toposorting the complete group of about 11000
> commits from an mbox file (which one would not ever do anyway).  And

Mutt is much faster (about 3 seconds to read and sort). Of course,
that's in C and the display doesn't look all that useful. :)

-Peff
