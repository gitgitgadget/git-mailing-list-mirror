From: Jeff King <peff@peff.net>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 16:09:16 -0400
Message-ID: <20070812200916.GB13298@sigill.intra.peff.net>
References: <85ir7kq42k.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> <85abswo9gf.fsf@lola.goethe.zz> <20070812200258.GA13298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJkb-0005Qf-LQ
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761442AbXHLUJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759448AbXHLUJW
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:09:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4180 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759348AbXHLUJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:09:21 -0400
Received: (qmail 4985 invoked by uid 111); 12 Aug 2007 20:09:28 -0000
X-Spam-Status: No, hits=-1.3 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 12 Aug 2007 16:09:27 -0400
Received: (qmail 15581 invoked by uid 1000); 12 Aug 2007 20:09:16 -0000
Content-Disposition: inline
In-Reply-To: <20070812200258.GA13298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55718>

On Sun, Aug 12, 2007 at 04:02:58PM -0400, Jeff King wrote:

> git-log \
>   --pretty=format:'From %H Mon Sep 17 00:00:00 2001%nFrom: %an <%ae>%nDate: %ad%nSubject: %s%nMessage-ID: <%H@none>%nReferences: %P%n%n%b' \

Er, sorry, that should be '%aD' in the date.

-Peff
