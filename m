From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Thu, 21 Jun 2012 01:18:17 -0400
Message-ID: <20120621051817.GA18102@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
 <7vk3z1u4lw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 07:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShZml-0005Rq-QY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 07:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab2FUFSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 01:18:22 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:40953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab2FUFSV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 01:18:21 -0400
Received: (qmail 1985 invoked by uid 107); 21 Jun 2012 05:18:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Jun 2012 01:18:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2012 01:18:17 -0400
Content-Disposition: inline
In-Reply-To: <7vk3z1u4lw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200381>

On Wed, Jun 20, 2012 at 01:10:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's an updated series that drops these lines and I hope will address
> > the commit message issues you brought up:
> [...]
> 
> Looks good modulo a minor nit.  Will queue.

You probably noticed a lot of nice review from Jonathan. I had hoped to
do another round exploring some alternatives we discussed, but didn't
get to it tonight, and now I'm going to be away from email for about 5
days.

I don't think there is anything _wrong_ in the series as it is, and
certainly the things we talked about changing could be built on top. So
if you want to hold it in pu for a week, I can revisit it next week. But
I'd also be just as happy to see it move to next, and revisit the topic
later by building on top.

-Peff
