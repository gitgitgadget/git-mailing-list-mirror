From: Jeff King <peff@peff.net>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 15:24:10 -0400
Message-ID: <20150309192409.GA4733@peff.net>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
 <87y4n6kvdu.fsf@fencepost.gnu.org>
 <CAJo=hJt_PHMEdpfRA0EKQyoH4XhYh89tvajewM28pgxzZ9ONMg@mail.gmail.com>
 <87twxuktzc.fsf@fencepost.gnu.org>
 <CAP8UFD1y86wqg5fpRn1wsMnn8JT9KXuDMgzcseH=sv8NBWO6wA@mail.gmail.com>
 <CAP2yMaJWLppUw2QY3rL7dZPaqVUf6G-UYVrvi35A_t03ow6E_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 20:24:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV3Ho-0000KL-LO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 20:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbbCITYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 15:24:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:59349 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752873AbbCITYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 15:24:14 -0400
Received: (qmail 7367 invoked by uid 102); 9 Mar 2015 19:24:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 14:24:14 -0500
Received: (qmail 9715 invoked by uid 107); 9 Mar 2015 19:24:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 15:24:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 15:24:10 -0400
Content-Disposition: inline
In-Reply-To: <CAP2yMaJWLppUw2QY3rL7dZPaqVUf6G-UYVrvi35A_t03ow6E_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265190>

On Mon, Mar 09, 2015 at 10:52:34AM -0700, Scott Chacon wrote:

> > * some of the pull request can be rejected even if the developers want
> > them, like this pull request to add back a list of contributors was:
> >
> > https://github.com/git/git-scm.com/pull/216
> >
> > (By the way this pull request talks about bugs in
> > https://github.com/git/git/graphs/contributors that are still not
> > fixed...)
> >
> 
> It should be noted that Peff has write access to this repository and I
> think the SFC manages the DNS for the site as well, so technically it
> is maintained "by us". If he had felt strongly about the addition, I
> easily could have been convinced to do it, but I didn't think it was
> helpful in a larger sense.

Yes, this. It was _my_ pull request, and as I noted in my final comment,
I agreed with closing it. That is not "rejected", but "withdrawn".

If somebody wants to open their own pull request, they can. But it has
been over 2 years, and I haven't seen anybody talk about this, let alone
offer to work on it.

If people don't like git-scm.com and want to have an alternate site,
especially one targeted at Git _developers_, I don't see a reason not
to. http://git.github.io is where I have been collecting GSoC materials,
and any community member who asks is welcome to have push access (and I
have offered to apply patches for people who do not want to use GitHub).
But aside from that GSoC content, there is nothing there (and the design
is awful; any takers?).

There is also the wiki at http://git.wiki.kernel.org. I prefer the
git.github.io site, because it is easier to manipulate using git, but if
having both is fracturing things, I'd be happy to shut it down.

So if anyone wants to contribute to Git's web presence, it seems there
are quite a few opportunities to do so.

-Peff
