From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: git-tag '-m' implies '-a'
Date: Mon, 24 Mar 2008 21:38:42 -0400
Message-ID: <20080325013842.GB15607@coredump.intra.peff.net>
References: <47E7BDB2.3030304@dirk.my1.cc> <20080324194308.GE14002@coredump.intra.peff.net> <7v1w5zvqbw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 02:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdy8Q-0005pD-Ac
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 02:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbYCYBiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 21:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYCYBiq
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 21:38:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4969 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbYCYBip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 21:38:45 -0400
Received: (qmail 31820 invoked by uid 111); 25 Mar 2008 01:38:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 24 Mar 2008 21:38:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2008 21:38:42 -0400
Content-Disposition: inline
In-Reply-To: <7v1w5zvqbw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78141>

On Mon, Mar 24, 2008 at 01:07:15PM -0700, Junio C Hamano wrote:

> Thanks for tidying up.  It makes my life easier.

No problem.

> >   - at least cc Junio on patch submissions to make sure he sees it
> >   - sign off your patch (either with commit -s or format-patch -s).
> 
> Heh, and you did not sign it off when you forwarded? ;-)

Heh. Believe it or not, that actually did occur to me. However, I'm not
really sure what it means to do that. As you have made clear in the
past, the signoff is _not_ "this looks good to me, please apply" but
rather "I am signing the Certificate of Origin."

And while I can only assume that everything in such an obvious patch is
kosher, it is _not_ true that:

  - I created or have the right to submit it under an open source
    license (DCO, part a)
  - The contribution was provided to me by somebody else who certified
    the above (DCO, part c)

I'm not clear on what part (b) of the DCO means. Is it making a
judgement that says "even though I have no license on this, it is
clearly a derivative work of git, which is GPL'd, and therefore it is
GPL'd"?

-Peff
