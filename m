From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] contrib/subtree: Testsuite cleanup
Date: Fri, 13 Nov 2015 00:05:48 -0500
Message-ID: <20151113050548.GB29708@sigill.intra.peff.net>
References: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, gitter.spiros@gmail.com, nod.helm@gmail.com,
	gitster@pobox.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Nov 13 06:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx6Yk-0000DK-8e
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbbKMFFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:05:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:56887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754716AbbKMFFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:05:51 -0500
Received: (qmail 12354 invoked by uid 102); 13 Nov 2015 05:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:05:51 -0600
Received: (qmail 20807 invoked by uid 107); 13 Nov 2015 05:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:06:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:05:48 -0500
Content-Disposition: inline
In-Reply-To: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281235>

On Thu, Nov 12, 2015 at 08:32:29PM -0600, David Greene wrote:

> Sending again with a proper From: address after rebasing on latest master.
> 
> Copying the maintainers because the origin patchset didn't get any
> comments and I'm unsure of how to proceed.

That's because Junio is on vacation and I am just slow (I'm filling in
for the next few weeks, but I haven't pushed out any updates yet). :)

> These are some old changes I have lying around that should get applied
> to clean up git-subtree's testbase.  With these changes post-mortem
> analysis is much easier and adding new tests can be done in an orderly
> fashion.

OK. Since these are all in a contrib subdir, and since AFAIK you are the
last person who volunteered to be the subsystem maintainer, I am happy
to pick them up if you think they're good.

I'll queue what's here for now, but review from interested parties is
welcome.

-Peff
