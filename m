From: Jeff King <peff@peff.net>
Subject: Re: Bug report: GIT PRO/Branches chapter
Date: Wed, 9 Sep 2015 05:16:46 -0400
Message-ID: <20150909091646.GB21892@sigill.intra.peff.net>
References: <CACwN7xFG0RrCZCZiUb=h-x2svV3B6Q1U5b3=3x6r08ZZM3mPmg@mail.gmail.com>
 <9039e46ed0bc66aec7b30c24183acdb0@dscho.org>
 <CACwN7xFU4yFeh=RPmPk4kwKBL5WjTB7pBY8RFFFNgf+k-a_Q4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Robert =?utf-8?B?TWFjaMOhxI1law==?= <lighthunt.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 11:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbV0-0000ZO-Am
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbbIIJQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 05:16:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:56648 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753028AbbIIJQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 05:16:49 -0400
Received: (qmail 8264 invoked by uid 102); 9 Sep 2015 09:16:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 04:16:49 -0500
Received: (qmail 29720 invoked by uid 107); 9 Sep 2015 09:16:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 05:16:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2015 05:16:46 -0400
Content-Disposition: inline
In-Reply-To: <CACwN7xFU4yFeh=RPmPk4kwKBL5WjTB7pBY8RFFFNgf+k-a_Q4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277540>

On Wed, Sep 09, 2015 at 03:16:38PM +0700, Robert Mach=C3=A1=C4=8Dek wro=
te:

> Sorry, I am new to git, I have just followed instructions at
> https://git-scm.com/community which says:
>=20
> Mailing List
> Questions or comments for the Git community can be sent to the mailin=
g
> list by using the email address git@vger.kernel.org. Bug reports
> should be sent to this mailing list.
>=20
> The last sentence is made with BOLD font and I assumed that this
> applies to the book as well as it is hosted on this domain (so what
> other bugs are they talking about BTW?)

Sorry, it _is_ confusing. The page you showed is about bugs in git
itself.  The website and the book are maintained separately, and bug
reporting should go to their issue trackers. Of course it doesn't
actually say that anywhere. :)

I've just opened https://github.com/git/git-scm.com/pull/590 to improve
this.

-Peff
