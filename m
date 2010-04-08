From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 8 Apr 2010 15:16:53 -0400
Message-ID: <20100408191653.GA14066@sigill.intra.peff.net>
References: <20100407204536.GA32382@coredump.intra.peff.net>
 <201004081812.50112.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:17:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzxDr-0004dn-La
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182Ab0DHTQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 15:16:57 -0400
Received: from peff.net ([208.65.91.99]:48407 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933150Ab0DHTQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 15:16:57 -0400
Received: (qmail 24744 invoked by uid 107); 8 Apr 2010 19:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Apr 2010 15:16:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 15:16:53 -0400
Content-Disposition: inline
In-Reply-To: <201004081812.50112.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144371>

On Thu, Apr 08, 2010 at 06:12:49PM +0200, Thomas Rast wrote:

> BTW, now that I seem to have a couple of users for those notes: what
> would you like to see in the "short" version (notes/terse)?  Improving

For me, the message-id is sufficient. I keep my own local archive of the
git list (because reading old threads in mutt is much nicer than on
gmane), and it is trivial to convert message-id into whatever gmane link
I want for referencing to other people.

-Peff
