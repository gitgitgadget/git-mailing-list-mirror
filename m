From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/9] Docs: send-email: Man page option ordering
Date: Tue, 30 Sep 2008 23:27:02 -0400
Message-ID: <20081001032701.GC24513@coredump.intra.peff.net>
References: <20080929174445.GA6015@coredump.intra.peff.net> <1222779512-58936-1-git-send-email-mfwitten@mit.edu> <1222779512-58936-2-git-send-email-mfwitten@mit.edu> <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: spearce@spearce.org, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 01 05:28:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KksNt-0002bP-Hz
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 05:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYJAD1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 23:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYJAD1G
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 23:27:06 -0400
Received: from peff.net ([208.65.91.99]:4887 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYJAD1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 23:27:06 -0400
Received: (qmail 14096 invoked by uid 111); 1 Oct 2008 03:27:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Sep 2008 23:27:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2008 23:27:02 -0400
Content-Disposition: inline
In-Reply-To: <1222779512-58936-3-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97188>

On Tue, Sep 30, 2008 at 07:58:26AM -0500, Michael Witten wrote:

> Now the man page lists the options in alphabetical
> order (in terms of the 'main' part of an option's
> name).
> 
> Signed-off-by: Michael Witten <mfwitten@mit.edu>

After following this series through a number of revisions, it looks good
to me now. So

Acked-by: Jeff King <peff@peff.net>

for the whole series.

I believe this particular patch is probably redundant, since 8/9 just
re-orders the manpage again later. So it could be dropped if somebody
feels like doing the work to rebase the later patches.

-Peff
