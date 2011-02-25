From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 04:09:08 -0500
Message-ID: <20110225090908.GA17145@sigill.intra.peff.net>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
 <20110224154908.GA29309@sigill.intra.peff.net>
 <4D667F1A.5060408@drmicha.warpmail.net>
 <20110224160027.GA30275@sigill.intra.peff.net>
 <4D6680F3.1000205@drmicha.warpmail.net>
 <20110224160932.GC30275@sigill.intra.peff.net>
 <4D676D99.2010600@drmicha.warpmail.net>
 <20110225090126.GA16861@sigill.intra.peff.net>
 <4D677054.9050908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:09:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pstfp-0006a3-KL
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1BYJJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:09:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab1BYJJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 04:09:10 -0500
Received: (qmail 32671 invoked by uid 111); 25 Feb 2011 09:09:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 25 Feb 2011 09:09:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Feb 2011 04:09:08 -0500
Content-Disposition: inline
In-Reply-To: <4D677054.9050908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167890>

On Fri, Feb 25, 2011 at 10:03:16AM +0100, Michael J Gruber wrote:

> > (which is why the default for commit with paths switched from "-i"
> > to "-o" long ago).
> 
> ...before my time (or under my radar).

Almost before my time, too. See 130fcca (git-commit: revamp the
git-commit semantics., 2006-02-05).

-Peff
