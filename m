From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2 v2] git-gui - provide commit base to the
 hooks/pre-commit script
Date: Mon, 21 Jun 2010 01:00:12 -0400
Message-ID: <20100621050012.GA13043@coredump.intra.peff.net>
References: <1275965763-18940-1-git-send-email-mlevedahl@gmail.com>
 <1275965763-18940-2-git-send-email-mlevedahl@gmail.com>
 <4C1C3288.5000308@gmail.com>
 <7vvd9drnn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	jsixt@viscovery.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 07:00:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQZ7O-00067T-Ub
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 07:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab0FUFAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 01:00:18 -0400
Received: from peff.net ([208.65.91.99]:46090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab0FUFAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 01:00:17 -0400
Received: (qmail 13921 invoked by uid 107); 21 Jun 2010 05:01:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 21 Jun 2010 01:01:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jun 2010 01:00:12 -0400
Content-Disposition: inline
In-Reply-To: <7vvd9drnn4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149414>

On Sun, Jun 20, 2010 at 09:54:39PM -0700, Junio C Hamano wrote:

> Mark Levedahl <mlevedahl@gmail.com> writes:
> 
> > Given the discussion on the first series (starting with)
> > <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>, and the absence
> > of objection to v2, I presume this sequence is ok?
> 
> I generally take absense of responses as absense of interest and/or
> support, not absense of objection.
> 
> For this particular patch, I am mostly indifferent (i.e. no objection, but
> no strong support neither).

Ditto. I don't personally have a use, but all of my concerns were
answered.

-Peff
