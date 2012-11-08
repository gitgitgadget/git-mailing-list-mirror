From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Introduce diff.submodule
Date: Thu, 8 Nov 2012 15:43:12 -0500
Message-ID: <20121108204312.GA8376@sigill.intra.peff.net>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
 <5092E535.3010701@web.de>
 <CALkWK0kdMbiTUYcSmY1OZOt6fjLTesi9y3S2LZvagjhu-0fn4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:43:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWYwk-0000e9-JE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab2KHUnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:43:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36698 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab2KHUnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:43:16 -0500
Received: (qmail 32709 invoked by uid 107); 8 Nov 2012 20:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:44:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:43:12 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0kdMbiTUYcSmY1OZOt6fjLTesi9y3S2LZvagjhu-0fn4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209190>

On Sun, Nov 04, 2012 at 11:28:17PM +0530, Ramkumar Ramachandra wrote:

> Jens Lehmann wrote:
> > Am 01.11.2012 11:43, schrieb Ramkumar Ramachandra:
> >> Hi,
> >>
> >> v1 is here:
> >> http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
> >>
> >> I've fixed the issues pointed out in the review by Jens.
> >
> > Thanks, looking good to me.
> 
> Peff, can we pick this up?

Thanks for prodding, I missed the original. I have a few comments, but
I'll respond directly.

Also, I was coincidentally looking at the same code today. You might
find this interesting:

  http://article.gmane.org/gmane.comp.version-control.git/209188

-Peff
