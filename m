From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 04:59:14 -0400
Message-ID: <20140516085914.GA26118@sigill.intra.peff.net>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <CAHVLzc=FcT6BcwX=kx7WKNqod4S0ePmvh5p+sgnQfWTPQ=7yTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 10:59:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDz9-0000Ts-TL
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbaEPI7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:59:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:52896 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756613AbaEPI7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:59:16 -0400
Received: (qmail 6199 invoked by uid 102); 16 May 2014 08:59:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 03:59:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 04:59:14 -0400
Content-Disposition: inline
In-Reply-To: <CAHVLzc=FcT6BcwX=kx7WKNqod4S0ePmvh5p+sgnQfWTPQ=7yTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249283>

On Fri, May 16, 2014 at 10:55:54AM +0200, Paolo Ciarrocchi wrote:

> On Fri, May 16, 2014 at 10:41 AM, Jeff King <peff@peff.net> wrote:
> > But that being said, this is Felipe's code. While we have a legal right
> > to distribute it in v2.0, if he would really prefer it out for v2.0, I
> > would respect that.
> 
> My understanding is that Felipe would prefer to keep it _in_ the git.git
> repository and eventually get it included in the core.

Yes, sorry if I was unclear. I meant "...if we are going to remove it,
and are considering leaving it in v2.0, we should respect his wishes to
remove it earlier if he wants to".

It is not his decision whether it stays in the core at all. That is
Junio's decision.

-Peff
