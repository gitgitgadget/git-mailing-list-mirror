From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Sat, 13 Apr 2013 02:00:31 -0400
Message-ID: <20130413060031.GA22374@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
 <7vfvywj4au.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QJJnSRVVJscLsTnXk5zdGbA2utefF5SO7=90+ttENew@mail.gmail.com>
 <7vd2u0hdmj.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 08:00:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQtVw-00042r-DW
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 08:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3DMGAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 02:00:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43697 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab3DMGAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 02:00:35 -0400
Received: (qmail 2083 invoked by uid 107); 13 Apr 2013 06:02:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 13 Apr 2013 02:02:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2013 02:00:31 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1pZW6OJ2nkegKFQq6=npPSiD4dX_z37t63B9baaFW16w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221052>

On Sat, Apr 13, 2013 at 12:42:29AM -0500, Felipe Contreras wrote:

> To me, the reality is obvious: my patch didn't require such a big
> commit message, the short version was fine, the only reason Jeff King
> insisted on a longer version is because the patch came from me.

Get over yourself. The reason I suggested a longer commit message for
your commit is because after spending several hours figuring out what
the current code did, and what it should be doing instead, I wanted to
document that effort so that I and other readers did not have to do it
again later. I didn't even review the other patch you mention, so I
could not possibly have come to the same point with it.

But hey, if you want to have paranoid fantasies that I'm persecuting you
(by writing the longer commit messages for you!), go ahead.

If you don't want me to review your patches, that's fine by me, too; our
discussions often end up frustrating, and it's clear we do not agree on
very much with respect to process or design. But if you don't want that,
please stop cc'ing me when you send out the patches.

-Peff
