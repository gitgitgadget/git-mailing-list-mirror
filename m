From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 11:58:51 -0400
Message-ID: <20100330155850.GA17763@coredump.intra.peff.net>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <20100328173225.GA2397@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 17:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwdqP-00053i-QR
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 17:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab0C3P7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 11:59:05 -0400
Received: from peff.net ([208.65.91.99]:50871 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab0C3P7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 11:59:04 -0400
Received: (qmail 21288 invoked by uid 107); 30 Mar 2010 15:59:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 11:59:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 11:58:51 -0400
Content-Disposition: inline
In-Reply-To: <20100328173225.GA2397@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143574>

On Sun, Mar 28, 2010 at 10:32:25AM -0700, Lars Damerow wrote:

> > > With those fixes, I think it should be ready for 'next'.
> > 
> > Yeah, looks nice; thanks both.
> 
> Thanks all for the suggestions! Jeff, shall I just squash in the doc
> patch you sent and resubmit the patches to the list?

No need. Usually Junio's "thanks both" means he picked up the patches
and squashed it himself, and indeed, it looks like he has your patches
(with my doc change) in his 'pu' branch.

-Peff
