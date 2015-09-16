From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only
 check
Date: Wed, 16 Sep 2015 16:00:59 -0400
Message-ID: <20150916200059.GA3161@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152428.GD29753@sigill.intra.peff.net>
 <f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
 <xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
 <20150916181237.GB17381@sigill.intra.peff.net>
 <xmqqwpvqp49e.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRtQG9km2xT_h8D02jUC_FLnp_QzBaX-+N7Bw01a1v5sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcItJ-0004Zz-6E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbbIPUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:01:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:60300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753907AbbIPUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:01:08 -0400
Received: (qmail 23416 invoked by uid 102); 16 Sep 2015 20:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:01:07 -0500
Received: (qmail 22709 invoked by uid 107); 16 Sep 2015 20:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:01:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:00:59 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRtQG9km2xT_h8D02jUC_FLnp_QzBaX-+N7Bw01a1v5sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278057>

On Wed, Sep 16, 2015 at 03:14:24PM -0400, Eric Sunshine wrote:

> On Wed, Sep 16, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> Speaking of which, how do you want the next round of patches? I'm
> >> hesitant to spam the list with 67 patches again, when only a fraction
> >> have changed (and for all but the _to/_r thing, I've posted my changes
> >> already).
> >
> > Cannot tell yet, as I am only halfway thru myself.
> 
> I'm also only about halfway through, plus trying dealing with other topics...

OK, I will hold back a resend for a few days, then.

-Peff
