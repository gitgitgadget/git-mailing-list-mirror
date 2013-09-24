From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 02:54:54 -0400
Message-ID: <20130924065454.GB7257@sigill.intra.peff.net>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
 <1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
 <20130924050343.GF2766@sigill.intra.peff.net>
 <CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
 <20130924053023.GA5875@sigill.intra.peff.net>
 <CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
 <20130924054053.GA6192@sigill.intra.peff.net>
 <CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
 <20130924061043.GA6678@sigill.intra.peff.net>
 <CAMP44s23FMeZP=xum1X9bvHuKVo=j8O=8_8DVNgXq9F7Cpsr7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:55:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMWW-0006yG-7C
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739Ab3IXGy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:54:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:53697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3IXGy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:54:58 -0400
Received: (qmail 4747 invoked by uid 102); 24 Sep 2013 06:54:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 01:54:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 02:54:54 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s23FMeZP=xum1X9bvHuKVo=j8O=8_8DVNgXq9F7Cpsr7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235277>

On Tue, Sep 24, 2013 at 01:31:48AM -0500, Felipe Contreras wrote:

> > I don't think it is the end of the world if we say "upstream branch". I
> > was hoping to find a term that could be both friendly and accurate.
> >
> > And failing that, I hoped you might say "I see what you are saying, but
> > I cannot think of a term that is more precise that does not sacrifice
> > friendliness". But as I seem incapable of even communicating the issue
> > to you, I'm giving up. It is not worth wasting more time on it.
> 
> And I was hoping you wouldn't use rhetorical warfare and label things
> as "inaccurate", "imprecise", "breadcrumbs".

FWIW, the term "breadcrumbs" was meant as a _good_ thing. I meant that
you are using a term that will link the user to other concepts that use
the same term (like "branch --set-upstream-to"), and that is something
we would like to keep.

As for the others, I find your accusation of rhetorical warfare
ridiculous. Insulting your patch with non-constructive insults would be
rhetorical. Saying "I think it has a flaw, here are my reasons, and I
hope we can come up with a solution that does not have that flaw without
weakening the other properties" is collaboration. Or an attempt at it
anyway.

I do not know why you and I have so much trouble communicating on even
basic things. I am willing to accept that it is entirely my fault. But
that does not change the fact that I often find it a waste of time, and
I plan to do less of it by ending my involvement in threads that seem to
be unproductive.

> At this porcelain level, branch.<name>.remote does not exist, so
> "upstream branch" is accurate. Period.

I do not agree with your first sentence at all. And your second one is
purely rhetorical.

I can elaborate if you really care, but I have a feeling you do not.

-Peff
