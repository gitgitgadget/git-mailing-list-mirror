From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 02:28:06 -0400
Message-ID: <20080612062806.GB28696@sigill.intra.peff.net>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home> <20080612062309.GA31816@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gIz-00026G-4w
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYFLG2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYFLG2K
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:28:10 -0400
Received: from peff.net ([208.65.91.99]:1636 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbYFLG2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:28:09 -0400
Received: (qmail 10384 invoked by uid 111); 12 Jun 2008 06:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 02:28:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 02:28:06 -0400
Content-Disposition: inline
In-Reply-To: <20080612062309.GA31816@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84721>

On Thu, Jun 12, 2008 at 02:23:09AM -0400, Jeff King wrote:

> Ah, right. Well, I am not opposed to getting rid of perl in the test
> scripts (there is core functionality provided by perl, so one can easily
> run git on a system with no perl at all).

Er, sorry. This should read: "there is _no_ core functionality provide
by perl".

-Peff
