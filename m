From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Mon, 13 Jun 2011 14:50:52 -0400
Message-ID: <20110613185052.GD17845@sigill.intra.peff.net>
References: <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
 <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 20:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWCE1-0001uW-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 20:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab1FMSu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 14:50:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab1FMSuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 14:50:55 -0400
Received: (qmail 16311 invoked by uid 107); 13 Jun 2011 18:51:04 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 14:51:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 14:50:52 -0400
Content-Disposition: inline
In-Reply-To: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175726>

On Fri, Jun 10, 2011 at 02:48:56PM -0700, Junio C Hamano wrote:

> >   git show INDEX:OURS:Makefile
> >
> > which is identical to what I wrote above, but is perhaps easier to
> > explain.
> 
> Why does anybody even want to say :2:Makefile to begin with?
> [...]
> I do not think whoever brought that "you can look at individual stages
> with :$n:$path" to this discussion was thinking straight. Yes, it is
> something you _could_ do, I've never found that particularly _useful_
> unless I was debugging git itself.

I think it may have been me, and I was bringing it up for completeness
in discussion of the new tokens. I don't actually use that concept very
often at all, so it can just be dropped from this discussion.

-Peff
