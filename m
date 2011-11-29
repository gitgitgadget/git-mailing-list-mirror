From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/13] credentials: add "cache" helper
Date: Tue, 29 Nov 2011 00:04:53 -0500
Message-ID: <20111129050453.GB32022@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110710.GH8417@sigill.intra.peff.net>
 <7vr50ru5d3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 06:05:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVFsJ-0001yZ-Vq
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 06:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab1K2FEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 00:04:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54224
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab1K2FEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 00:04:55 -0500
Received: (qmail 28434 invoked by uid 107); 29 Nov 2011 05:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 00:11:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 00:04:53 -0500
Content-Disposition: inline
In-Reply-To: <7vr50ru5d3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186044>

On Mon, Nov 28, 2011 at 04:42:00PM -0800, Junio C Hamano wrote:

> > +		askpass: Password for '\''https://user1@example.com'\'':
> > +	'
> 
> Missing EOF for here document; I fixed this already in 'pu', but please
> squash it in when rerolling after 1.7.8 final.

Thanks, will do.

-Peff
