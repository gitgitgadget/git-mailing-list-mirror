From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 17:50:20 -0400
Message-ID: <20120810215020.GA1841@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
 <20120810174605.GA29113@sigill.intra.peff.net>
 <7vlihmk2ab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:50:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szx6L-0005J3-9a
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641Ab2HJVua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:50:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34077 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758086Ab2HJVu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:50:29 -0400
Received: (qmail 2848 invoked by uid 107); 10 Aug 2012 21:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 17:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 17:50:20 -0400
Content-Disposition: inline
In-Reply-To: <7vlihmk2ab.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203270>

On Fri, Aug 10, 2012 at 11:52:28AM -0700, Junio C Hamano wrote:

> When evaluating a change in the interoperability area, it does not
> add much more confidence to the correctness that the change has been
> in use for months with the same partner than that it has been used
> to talk to many different partners even for a short period of time,
> I guess.

Traditionally our interoperability testing has been to cook things in
"next" and "master" and see if anybody complains. It would be nice to
have an interoperability test suite that could hit some common hosting
sites, as well as older versions of git-core itself. I suspect
automating that would be a big pain, though.

-Peff
