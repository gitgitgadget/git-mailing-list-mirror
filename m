From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 17 Mar 2011 15:54:59 -0400
Message-ID: <20110317195459.GA2257@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
 <1300371608.16335.1.camel@wpalmer.simply-domain>
 <20110317193450.GD20508@sigill.intra.peff.net>
 <AANLkTin35yjU-JDA8z4_aRFhV+-_hHiurWjaid8Th919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:55:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JHn-0007ts-D4
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab1CQTzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:55:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35240
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab1CQTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:55:00 -0400
Received: (qmail 26993 invoked by uid 107); 17 Mar 2011 19:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:54:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin35yjU-JDA8z4_aRFhV+-_hHiurWjaid8Th919@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169270>

On Thu, Mar 17, 2011 at 09:51:55PM +0200, Alexei Sholik wrote:

> I think, it would be nice to have a tool, which output all the
> different stats about the repo, maybe even in a gui. But it definitely
> doesn't belong in the Git project.

Check out:

  http://gitstats.sourceforge.net/

It currently doesn't have a lot of per-file stats like this, but I'm
sure patches are welcome. :)

-Peff
