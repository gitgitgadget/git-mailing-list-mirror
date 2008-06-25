From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] Allow git-apply to ignore the hunk headers (AKA
	recountdiff)
Date: Wed, 25 Jun 2008 01:45:19 -0400
Message-ID: <20080625054519.GC2209@sigill.intra.peff.net>
References: <20080624050901.GA19224@sigill.intra.peff.net> <200806242108.16379.trast@student.ethz.ch> <7vfxr29zju.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNpi-00089P-9j
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbYFYFpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbYFYFpW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:45:22 -0400
Received: from peff.net ([208.65.91.99]:1438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754210AbYFYFpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:45:22 -0400
Received: (qmail 10518 invoked by uid 111); 25 Jun 2008 05:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 25 Jun 2008 01:45:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2008 01:45:19 -0400
Content-Disposition: inline
In-Reply-To: <7vfxr29zju.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86236>

On Tue, Jun 24, 2008 at 04:35:33PM -0700, Junio C Hamano wrote:

> I think I've already mentioned the above two points when this was
> originally posted.
> 
> Somewhat disgusted...

Sorry, this is my fault. I hadn't looked at the recount patches closely,
but I had thought they were submit-worthy, so I encouraged Thomas to
include them in his series (since his patch depends on them).

I'll try to look them over more closely in the next day or two.

-Peff
