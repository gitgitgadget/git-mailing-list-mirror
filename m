From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Fri, 6 Mar 2015 11:02:58 -0500
Message-ID: <20150306160257.GB18804@peff.net>
References: <20150224220923.GA23344@peff.net>
 <CAP8UFD27xaJU3QFuQZqADmh=ZseiN=Y1WCFPk4v4RzizK=2Xtg@mail.gmail.com>
 <xmqqlhjb13s3.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2akA-ci8wXiE2bD0MpPa5v4_8bbc_yWEec0QaV31GzUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	git@sfconservancy.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:03:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTuiQ-0007v4-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbbCFQDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:03:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:57260 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753284AbbCFQDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:03:00 -0500
Received: (qmail 21455 invoked by uid 102); 6 Mar 2015 16:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 10:03:00 -0600
Received: (qmail 19556 invoked by uid 107); 6 Mar 2015 16:03:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 11:03:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2015 11:02:58 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2akA-ci8wXiE2bD0MpPa5v4_8bbc_yWEec0QaV31GzUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264934>

On Fri, Mar 06, 2015 at 01:06:15PM +0100, Christian Couder wrote:

> And anyway in the "case-by-case as needed basis", you still have the
> problem to decide how much to pay back each one, in case people ask
> for more than what is available. In this case it could be seen as very
> unfair that rules are defined or negociated on the fly. (Though I
> agree that in the past it went very well, but then I think it can only
> improve things to have some rules defined at the beginning.)

I agree it would be nice to have some well-defined rules so that
everything is fair. But I do not know what those rules should be.

You have said things like "5 most important" in your email, but I do not
see any metric for defining that. Is it "git shortlog"? I am not sure
that is the best metric (try generating your own list and comparing it
with shortlog). Also, is it "shortlog" over all time, or "shortlog
--since=1.year.ago", or some other time period.

I had hoped by inviting people to express their need, that the
invitation would be equally open to everyone, and we could then get an
idea of the scope of need.

By the way, nobody has contacted me asking for travel money at this
point.

-Peff
