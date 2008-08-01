From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 1 Aug 2008 10:41:54 -0400
Message-ID: <20080801144153.GA14102@sigill.intra.peff.net>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com> <7vmyjxtco3.fsf@gitster.siamese.dyndns.org> <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com> <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOvqM-0002QG-CG
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 16:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYHAOl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYHAOl5
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 10:41:57 -0400
Received: from peff.net ([208.65.91.99]:2242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbYHAOl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 10:41:56 -0400
Received: (qmail 13205 invoked by uid 111); 1 Aug 2008 14:41:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 01 Aug 2008 10:41:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2008 10:41:54 -0400
Content-Disposition: inline
In-Reply-To: <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91072>

On Fri, Aug 01, 2008 at 01:20:10AM -0700, Junio C Hamano wrote:

> Thanks again for the patch.  Somewhere I heard that there are 10 Rubyista
> git users for every non Rubyista git user, so I am sure somebody would
> comment on your patch in a day or two.  Perhaps we might even get Python
> and Perl hunk patterns (although I suspect Perl people are happy with the
> default one we stole from GNU diff) to go with it ;-).

I keep a lot of Perl in git, and yes, I am quite happy with the default
regex.

-Peff
