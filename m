From: Jeff King <peff@peff.net>
Subject: Re: No common commits question
Date: Sat, 14 Jun 2008 05:29:23 -0400
Message-ID: <20080614092923.GB22538@sigill.intra.peff.net>
References: <1213435065.9800.13.camel@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7S5Y-0000sj-Lt
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872AbYFNJ30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbYFNJ30
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:29:26 -0400
Received: from peff.net ([208.65.91.99]:2463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbYFNJ3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:29:25 -0400
Received: (qmail 7661 invoked by uid 111); 14 Jun 2008 09:29:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 05:29:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 05:29:23 -0400
Content-Disposition: inline
In-Reply-To: <1213435065.9800.13.camel@neo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84999>

On Sat, Jun 14, 2008 at 11:17:45AM +0200, Lars Jarnbo Pedersen wrote:

> I have been tracking the Linux kernel with for at least a year now doing
> frequent pulls (once every other day or so). I'm not doing any
> development so it should be a clean update everytime. However once in a
> while I get a "no common commit" warning and git starts to download the
> entire repo again. (It happened again today - therefore this mail)
> [...]
> - git version 1.5.4.3

This has been noted a few times on the list (try searching for "no
common commits"), and there were some patches a few months ago that made
it into 1.5.5.

Can you try with the latest stable release, 1.5.5.4?

-Peff
