From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Simplify and fix --first-parent implementation
Date: Sat, 26 Apr 2008 08:27:42 -0400
Message-ID: <20080426122741.GA32457@sigill.intra.peff.net>
References: <20080425234556.D60FD5461@aristoteles.cuci.nl> <7viqy5o4om.fsf@gitster.siamese.dyndns.org> <20080426115956.GB19558@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sat Apr 26 14:28:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpjW9-00075I-Pl
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 14:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYDZM1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 08:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYDZM1n
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 08:27:43 -0400
Received: from peff.net ([208.65.91.99]:2824 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYDZM1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 08:27:42 -0400
Received: (qmail 18444 invoked by uid 111); 26 Apr 2008 12:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 26 Apr 2008 08:27:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2008 08:27:42 -0400
Content-Disposition: inline
In-Reply-To: <20080426115956.GB19558@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80371>

On Sat, Apr 26, 2008 at 01:59:56PM +0200, Stephen R. van den Berg wrote:

> >Please also sign your patch.
> 
> Just with git-commit -s ?  Or do I need to get gpg involved?

With git-commit -s; check out Documentation/SubmittingPatches.

> P.S. No reaction on the other patches means that they're accepted, or do
> I need to resubmit them as well (signed)?

I for one would have liked to see more explanation on your "check for
circular references" patch. I am not clear on what circumstances create
such circular references.

-Peff
