From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Tue, 24 Nov 2015 15:43:00 -0500
Message-ID: <20151124204259.GD7174@sigill.intra.peff.net>
References: <20151120140937.GA17079@sigill.intra.peff.net>
 <565433A9.5050707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:43:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KQd-0004FU-9p
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 21:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbbKXUnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 15:43:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:33397 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754573AbbKXUnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 15:43:03 -0500
Received: (qmail 21496 invoked by uid 102); 24 Nov 2015 20:43:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:43:02 -0600
Received: (qmail 18050 invoked by uid 107); 24 Nov 2015 20:43:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:43:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 15:43:00 -0500
Content-Disposition: inline
In-Reply-To: <565433A9.5050707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281627>

On Tue, Nov 24, 2015 at 10:53:45AM +0100, Michael J Gruber wrote:

> > and all topic branches at:
> > 
> >     https://github.com/peff/git/
> > 
> > But note that I will _not_ be pushing to kernel.org.
> 
> Does peff/git include the integration branches, too?

Yes, it does.

> Also, that one should be uncontroversial (f[l]amous last words):
> 
> From: Michael J Gruber <git@drmicha.warpmail.net>
> Subject: [PATCH] Documentation/diff: give --word-diff-regex=. example
> Date: Fri, 20 Nov 2015 14:36:14 +0100
> 
> Message-ID:
> <6697f80b679b2bc910aa02a0fc945453be38c532.1448026505.git.git@drmicha.warpmail.net>

Thanks. It came while I was doing the cycle. I'll include it in the
current one.

-Peff
