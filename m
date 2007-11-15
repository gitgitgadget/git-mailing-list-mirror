From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Thu, 15 Nov 2007 02:27:03 -0500
Message-ID: <20071115072703.GF10185@sigill.intra.peff.net>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com> <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org> <3461FD6E-1C46-4278-9EB0-5D730BB99084@wincent.com> <20071115071558.GE10185@sigill.intra.peff.net> <ee77f5c20711142320x1a070b21xf00f0853fe09e34c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZ8J-0004yF-RG
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006AbXKOH1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbXKOH1J
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:27:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3345 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbXKOH1I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:27:08 -0500
Received: (qmail 6945 invoked by uid 111); 15 Nov 2007 07:27:06 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 Nov 2007 02:27:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2007 02:27:03 -0500
Content-Disposition: inline
In-Reply-To: <ee77f5c20711142320x1a070b21xf00f0853fe09e34c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65077>

On Thu, Nov 15, 2007 at 06:20:10PM +1100, David Symonds wrote:

> > >>> +A `filter` attribute can be set to a string value which names a
> > >>> filter driver specified in the configuration.
> 
> "that" should be used to introduce restrictive clauses (as you point
> out), and this use should be a restrictive clause, since you can't set
> the attribute to just any value--you need to set it to the value
> *that* names the desired filter driver.

I don't see it as restrictive, but I can see how one would. I think it
is not a case of "this wording is correct" but rather "this wording
means one thing, and the other wording means another."

But the two meanings are likely to be interpreted the same way, so I
think it isn't a big deal (although "which" without a comma _is_ wrong
:) ).

-Peff
