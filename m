From: Jeff King <peff@peff.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 05:03:17 -0400
Message-ID: <20090513090317.GA3421@sigill.intra.peff.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com> <20090513083203.GA25058@sigill.intra.peff.net> <4A0A8871.6080107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 13 11:03:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4AN6-00066b-NR
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbZEMJDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 05:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757411AbZEMJDS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:03:18 -0400
Received: from peff.net ([208.65.91.99]:45581 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZEMJDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 05:03:17 -0400
Received: (qmail 13317 invoked by uid 107); 13 May 2009 09:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 May 2009 05:03:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2009 05:03:17 -0400
Content-Disposition: inline
In-Reply-To: <4A0A8871.6080107@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119009>

On Wed, May 13, 2009 at 10:44:33AM +0200, Johannes Sixt wrote:

> Unfortunately, the case with this warning is not that "simple" because it
> is not about a planned change of the default behavior, but about a default
> behavior that may be unexpected for newbies (see the release notes of
> 1.6.3). I *can* understand that Caleb is upset by the warning, since he's
> comfortable with the (current and future) default behavior. But I don't
> know what to do in cases like these.

I thought this was in preparation for an eventual change, but I might be
wrong (1.6.3 introduced several such warnings).

Regardless, my point was: the warning was introduced for a purpose
(either to point out potentially confusing behavior, or to warn the user
about an upcoming change in default behavior). Showing up now and saying
"I don't like this warning" without addressing any of the points in the
original discussion or making any sort of proposal to try to accomplish
the same goals is just counterproductive.

-Peff
