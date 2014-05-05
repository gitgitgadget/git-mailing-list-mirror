From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Mon, 5 May 2014 18:01:12 -0400
Message-ID: <20140505220112.GA17610@sigill.intra.peff.net>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <20140505050803.GA6569@sigill.intra.peff.net>
 <69f827ea-0ba2-4ca0-b711-002e1a0010b7@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, greened@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiB1-0007Xo-6T
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbaEEWBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 18:01:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:45576 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756669AbaEEWBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 18:01:14 -0400
Received: (qmail 9192 invoked by uid 102); 5 May 2014 22:01:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 17:01:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 18:01:12 -0400
Content-Disposition: inline
In-Reply-To: <69f827ea-0ba2-4ca0-b711-002e1a0010b7@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248181>

[fixed David's address in cc list]

On Tue, May 06, 2014 at 07:54:30AM +1000, James Denholm wrote:

> Given that subtree subtree doesn't really generate a lot of discussion,
> would it be advisable to wrap this up (barring further discussion) and send
> it off to Junio rather than waiting for further community consensus?

I do not know if "lack of discussion" is a good reason to consider
something in good shape; oftentimes it is a sign that nobody is
interested in the area. We usually rely on "area maintainers" to give an
OK to the patches if they are not something that the maintainer himself
has an interest in.

However, in this case, you did get review, and I think it is pretty easy
to see the patches are good even if one does not care about the
particular area. So I think they are fine to pass on and apply.

Note also that patches like this are a great place to get started, as
they help build trust in a contributor, who can later help out with
area maintenance.

-Peff
