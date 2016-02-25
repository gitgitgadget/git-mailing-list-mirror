From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] Make README more pleasant to read
Date: Thu, 25 Feb 2016 01:14:56 -0500
Message-ID: <20160225061456.GA3921@sigill.intra.peff.net>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <20160224102247.GA21152@sigill.intra.peff.net>
 <vpqziuq6xha.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:15:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpCc-0005Ge-SM
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbcBYGPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:15:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:48833 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750739AbcBYGO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:14:59 -0500
Received: (qmail 16499 invoked by uid 102); 25 Feb 2016 06:14:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 01:14:59 -0500
Received: (qmail 16530 invoked by uid 107); 25 Feb 2016 06:15:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 01:15:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 01:14:56 -0500
Content-Disposition: inline
In-Reply-To: <vpqziuq6xha.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287330>

On Wed, Feb 24, 2016 at 02:37:05PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 23, 2016 at 06:40:24PM +0100, Matthieu Moy wrote:
> >
> >>  README => README.md | 54 ++++++++++++++++++++++++++++-------------------------
> >>  t/t7001-mv.sh       |  2 +-
> >
> > I do not overly care, but I wonder if it would be nice to keep README as
> > a symlink.
> 
> I can add it if people want to see it, but we already have so many files
> at the root, I'd rather avoid adding duplicates through symlinks.

That's reasonable. I thought it might appease the "I use `less README`
to view the README" crowd, but it is probably not that hard to find the
`.md` variant.

-Peff
