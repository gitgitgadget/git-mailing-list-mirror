From: Jeff King <peff@peff.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 04:32:03 -0400
Message-ID: <20090513083203.GA25058@sigill.intra.peff.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49sv-0001QS-WC
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbZEMIcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758083AbZEMIcG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:32:06 -0400
Received: from peff.net ([208.65.91.99]:38188 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbZEMIcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:32:04 -0400
Received: (qmail 11012 invoked by uid 107); 13 May 2009 08:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 May 2009 04:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2009 04:32:03 -0400
Content-Disposition: inline
In-Reply-To: <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119005>

On Wed, May 13, 2009 at 01:26:26AM -0400, Caleb Cushing wrote:

> On Tue, May 12, 2009 at 7:11 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > Seriously, we had that discussion when the feature (change of default
> > behaviour) and warning were introduced, so it's too late for a change.
> > But it's never too late to do
> >
> 
> It's open source. it's too  late to change 1.6.3 but the error message
> could be easily remove in 1.6.3.1
> 
> I'll reiterate that I shouldn't have to explicitly set default
> behavior to not see error messages.

Are you proposing not to change the default behavior? If you are, then
you should at least address the concerns raised in all of the existing
threads.

Or are you proposing to still change the default behavior, but drop the
warning whose aim is to inform people about the impending change? In
that case, I think you should address the concerns that arose from
previous changes in default behavior (and which this warning is meant to
address), and propose an alternate plan for making the transition more
smooth.

-Peff
