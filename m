From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] t800?-blame.sh: retitle uniquely
Date: Mon, 13 Dec 2010 14:58:46 -0500
Message-ID: <20101213195846.GA18355@sigill.intra.peff.net>
References: <4D05F1EA.9000403@viscovery.net>
 <52f777e518583955f78b71e96b3c8ff53d25b608.1292256498.git.git@drmicha.warpmail.net>
 <20101213170734.GA24736@sigill.intra.peff.net>
 <7vfwu1zc0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSEXw-0006ms-51
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab0LMT6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 14:58:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0LMT6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 14:58:50 -0500
Received: (qmail 10921 invoked by uid 111); 13 Dec 2010 19:58:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 13 Dec 2010 19:58:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Dec 2010 14:58:46 -0500
Content-Disposition: inline
In-Reply-To: <7vfwu1zc0x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163590>

On Mon, Dec 13, 2010 at 11:51:58AM -0800, Junio C Hamano wrote:

> >   t7500-commit.sh
> >   t7501-commit.sh
> >   t7502-commit.sh
> >   t7509-commit.sh
> 
> t7509 seems to be about the authorship, so it is easy to rename it to
> t7509-commit-authorship or something, but unfortunately I do not see
> unifying theme in any of t750[012].  They test random things and there
> seem to be overlaps.

I read through them and came to the same conclusion.

> Perhaps somebody wants to consolidate these three into one?

I think this falls into my "would be nice if it had been written cleaner
in the first place, but is not worth the time to clean up" category. But
if somebody else is willing to work on it, I have no objection. :)

-Peff
