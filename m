From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git-am.txt: Use date instead of time or timestamp
Date: Mon, 4 May 2009 03:25:23 -0400
Message-ID: <20090504072523.GA12759@coredump.intra.peff.net>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com> <1241419618-20304-2-git-send-email-bebarino@gmail.com> <1241419618-20304-3-git-send-email-bebarino@gmail.com> <20090504071534.GB12654@coredump.intra.peff.net> <7vprep49h3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 09:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0sYS-0007vd-Aq
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 09:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbZEDHZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 03:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZEDHZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 03:25:25 -0400
Received: from peff.net ([208.65.91.99]:49674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbZEDHZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 03:25:25 -0400
Received: (qmail 16681 invoked by uid 107); 4 May 2009 07:25:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 May 2009 03:25:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 May 2009 03:25:23 -0400
Content-Disposition: inline
In-Reply-To: <7vprep49h3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118217>

On Mon, May 04, 2009 at 12:23:52AM -0700, Junio C Hamano wrote:

> >>  	commit creation as the committer date. This allows the
> >> -	user to lie about author timestamp by using the same
> >> +	user to lie about the author date by using the same
> >>  	timestamp as the committer date.
> >
> > But you leave the "timestamp" in the next context line?
> >
> > The other two patches in the series look fine to me, though.
> 
> Likewise.  Perhaps "using the same value as the committer date" sounds
> better?

Much better IMHO.

-Peff
