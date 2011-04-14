From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 15:15:22 -0400
Message-ID: <20110414191522.GA4862@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:15:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAS0q-0006H4-I1
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000Ab1DNTPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:15:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50015
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932492Ab1DNTPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:15:24 -0400
Received: (qmail 2240 invoked by uid 107); 14 Apr 2011 19:16:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 15:16:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 15:15:22 -0400
Content-Disposition: inline
In-Reply-To: <20110414190901.GA1184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171536>

On Thu, Apr 14, 2011 at 03:09:01PM -0400, Jeff King wrote:

> but after looking at the codepath, it is must worse than just textconv.
> Try this:

Ugh, that should be "much worse" of course.

-Peff
