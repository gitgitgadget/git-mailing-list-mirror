From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] git-add--interactive: manual hunk editing mode
Date: Mon, 23 Jun 2008 15:57:19 -0400
Message-ID: <20080623195719.GB29569@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806120855.26847.trast@student.ethz.ch> <20080612071311.GA32491@sigill.intra.peff.net> <200806131748.44867.trast@student.ethz.ch> <20080623183840.GA28887@sigill.intra.peff.net> <alpine.DEB.1.00.0806231952360.6440@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsBP-0005VE-FT
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbYFWT5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbYFWT5W
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:57:22 -0400
Received: from peff.net ([208.65.91.99]:2323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094AbYFWT5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:57:22 -0400
Received: (qmail 28800 invoked by uid 111); 23 Jun 2008 19:57:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 15:57:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 15:57:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806231952360.6440@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85912>

On Mon, Jun 23, 2008 at 07:54:29PM +0100, Johannes Schindelin wrote:

> I am not sure when I will have time for that (particularly given that I 
> got sidetracked with the OPTION_OPTIONS patch, when I should have worked 
> on something completely different).

Heh, I know the feeling. ;)

> In the meantime, feel free to submit in my name.

Do you remember off the top of your head whether more work was needed?
They looked good to me, but then I seem to recall you saying in another
thread that Junio pointed out some flaw with your approach (but I never
quite understood what the flaw was).

-Peff
