From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] prepare_packed_git(): find more garbage
Date: Fri, 18 Dec 2015 21:03:25 -0500
Message-ID: <20151219020324.GA3118@sigill.intra.peff.net>
References: <20151215232534.GA30998@sigill.intra.peff.net>
 <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
 <20151219020247.GA3098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 03:03:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA6rr-0002iQ-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 03:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbbLSCD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 21:03:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:44494 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932203AbbLSCD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 21:03:27 -0500
Received: (qmail 20555 invoked by uid 102); 19 Dec 2015 02:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 20:03:27 -0600
Received: (qmail 2213 invoked by uid 107); 19 Dec 2015 02:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 21:03:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Dec 2015 21:03:25 -0500
Content-Disposition: inline
In-Reply-To: <20151219020247.GA3098@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282729>

On Fri, Dec 18, 2015 at 09:02:47PM -0500, Jeff King wrote:

> I left a few comments on 3/3. I don't think it's _wrong_, but I think we
> can be a bit more thorough (and IMHO, a little more maintainable, but
> others might disagree).

Oh, and I forgot to say thank you for working on this. :)

-Peff
