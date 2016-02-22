From: Jeff King <peff@peff.net>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Mon, 22 Feb 2016 17:02:48 -0500
Message-ID: <20160222220248.GC18250@sigill.intra.peff.net>
References: <vpqoabox66p.fsf@anie.imag.fr>
 <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
 <vpqd1s2e74l.fsf@anie.imag.fr>
 <20160212130446.GB10858@sigill.intra.peff.net>
 <vpqd1s04zzs.fsf@anie.imag.fr>
 <CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
 <vpqziutkps7.fsf@anie.imag.fr>
 <20160222214246.GE15595@sigill.intra.peff.net>
 <xmqqlh6c5ryz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:03:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyZV-0005uG-93
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbcBVWCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:02:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:46982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755613AbcBVWCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:02:51 -0500
Received: (qmail 19649 invoked by uid 102); 22 Feb 2016 22:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:02:50 -0500
Received: (qmail 22426 invoked by uid 107); 22 Feb 2016 22:02:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:02:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:02:48 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh6c5ryz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286957>

On Mon, Feb 22, 2016 at 01:56:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree that there are a lot of different ways to resolve each instance,
> > and it will vary from case to case. I think the original point of a
> > microproject was to do something really easy and not contentious, so
> > that the student could get familiar with all of the other parts of the
> > cycle: writing a commit message, formatting the patch, posting to the
> > list, etc.
> 
> I had an impression that Micros are also used as an aptitude test,
> and one important trait we want to see in a potential developer is
> how well s/he interacts with others in such a discussion.  So "easy
> and not contentious" might not be a very good criteria.
> 
> I dunno.

I sort-of agree. I think of the microprojects as more of a "fizz-buzz",
where you intentionally keep the technical level very low so that you
can evaluate the other things.

So I think a little back and forth is good; almost everybody does
something a little wrong in their first patch submission. But I'd worry
about a topic that is going to involve a lot of bikeshedding or subtle
nuances to finding the correct solution. I certainly think _some_
candidates can handle that, but for the ones who cannot, it may
frustrate all involved.

-Peff
