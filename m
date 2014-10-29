From: Jeff King <peff@peff.net>
Subject: Re: Bug reporting method too hard to find
Date: Wed, 29 Oct 2014 16:17:56 -0400
Message-ID: <20141029201756.GB27413@peff.net>
References: <20141029115857.GB33348@bat.dot-bit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Francis Irving <francis@scraperwiki.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZgx-0008DS-0K
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 21:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbaJ2UR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 16:17:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:34995 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752359AbaJ2UR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 16:17:58 -0400
Received: (qmail 1585 invoked by uid 102); 29 Oct 2014 20:17:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 15:17:58 -0500
Received: (qmail 2803 invoked by uid 107); 29 Oct 2014 20:18:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 16:18:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2014 16:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20141029115857.GB33348@bat.dot-bit.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 11:58:57AM +0000, Francis Irving wrote:

> I could not find out how to report a bug. In the end, a colleague
> had to tell me.

Thanks for your suggestions; they all seem like improvements.  I just
opened:

  https://github.com/git/git-scm.com/pull/462

which implements most of them. Unlike development of git itself, which
happens on the mailing list, development of the website is centered
around that GitHub repository; if you have further suggestions for the
site, they'll probably get more attention by opening an issue there.

-Peff
