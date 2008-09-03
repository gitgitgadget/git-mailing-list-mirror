From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 16:33:24 -0400
Message-ID: <20080903203324.GA32223@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191732.GC31195@coredump.intra.peff.net> <alpine.LNX.1.10.0809032200490.32548@pollux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaz3i-00065U-QD
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYICUd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbYICUd1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:33:27 -0400
Received: from peff.net ([208.65.91.99]:4079 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYICUd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:33:27 -0400
Received: (qmail 31545 invoked by uid 111); 3 Sep 2008 20:33:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 16:33:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 16:33:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0809032200490.32548@pollux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94849>

On Wed, Sep 03, 2008 at 10:06:45PM +0200, Michael Dressel wrote:

> I'm sorry for not properly citing you. I did mention you in the commit
> message which is wrong. So what would be the right way? Just adding a
> line Signed-off-by: Jeff King <peff@peff.net>
> before the ---?
> Or resending your original patch and than my patch on top of yours?

Oh, you cited me just fine. The Signed-off-by line isn't for credit; it
indicates that you agree to the Developer's Certificate of Origin. IOW,
it says "I wrote this (or I know who did) and I know it can be licensed
for the project". So what I was saying was not "oh, you didn't credit me
properly" but rather "you may also add to the official record that the
parts I wrote are fine to be GPL'd for the project."

So in this case, I would simply add my Signed-off-by to the commit
message when you resend the patch.

-Peff
