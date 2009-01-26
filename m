From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 22:45:23 -0500
Message-ID: <20090126034523.GA15407@sigill.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <7v4ozmbunl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRIR0-0001zk-HI
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbZAZDp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZAZDp1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:45:27 -0500
Received: from peff.net ([208.65.91.99]:36870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZAZDp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:45:26 -0500
Received: (qmail 32750 invoked by uid 107); 26 Jan 2009 03:45:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 25 Jan 2009 22:45:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 22:45:23 -0500
Content-Disposition: inline
In-Reply-To: <7v4ozmbunl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107168>

On Sun, Jan 25, 2009 at 07:42:06PM -0800, Junio C Hamano wrote:

> We seem to think the same way these days, so I do not have very much to
> add on top of what you already said.  I'll fix one typo, though.

Heh. Am I corrupting you, or you me?

> > But this can break down in two ways:
> >
> >   1. Sometimes we blur the line of plumbing and porcelain, where
> >      functionality is available only through plumbing. For example,
> 
> s/through plumbing/through Porcelain/.

Oops, yes, thank you. That was what I meant.

-Peff
