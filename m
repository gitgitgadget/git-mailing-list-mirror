From: Jeff King <peff@peff.net>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 26 Jun 2008 13:51:24 -0400
Message-ID: <20080626175124.GA3300@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <20080621214241.GA3839@dualtron.vpn.rwth-aachen.de> <20080622072420.GA5161@dualtron.vpn.rwth-aachen.de> <g3v3s1$bok$1@ger.gmane.org> <43234A8B-3201-4F4F-A9A8-3756FC95A422@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 19:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBvea-0006Wr-CI
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 19:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbYFZRv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbYFZRv2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 13:51:28 -0400
Received: from peff.net ([208.65.91.99]:2776 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbYFZRv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 13:51:27 -0400
Received: (qmail 28135 invoked by uid 111); 26 Jun 2008 17:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 13:51:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 13:51:24 -0400
Content-Disposition: inline
In-Reply-To: <43234A8B-3201-4F4F-A9A8-3756FC95A422@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86466>

On Thu, Jun 26, 2008 at 12:17:53PM +0200, Wincent Colaiuta wrote:

> Follow-up discussion in early May, 31 messages:
>
>   http://article.gmane.org/gmane.comp.version-control.git/80957/

And I posted several patches in that thread to make paging configuration
more fine-grained, but they got caught up in some setup_git_* bermuda
triangle. Dan (and others who dislike the new change), I would be very
happy if you wanted to take a look at them and see if you can address
some of the issues I raised.

-Peff
