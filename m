From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] Docs: send-email: Added all config variables to
	man end
Date: Sat, 27 Sep 2008 23:18:22 -0400
Message-ID: <20080928031822.GB15696@sigill.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 05:19:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjmon-0005j5-Tg
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 05:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYI1DSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 23:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYI1DSY
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 23:18:24 -0400
Received: from peff.net ([208.65.91.99]:1910 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYI1DSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 23:18:24 -0400
Received: (qmail 2989 invoked by uid 111); 28 Sep 2008 03:18:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 27 Sep 2008 23:18:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Sep 2008 23:18:22 -0400
Content-Disposition: inline
In-Reply-To: <1222564196-84202-7-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96939>

On Sat, Sep 27, 2008 at 08:09:55PM -0500, Michael Witten wrote:

> Admittedly, I didn't take much pride in my work, but
> I'm not trying to solve this problem.

Remember that your commit message is supposed to be convincing us that
your patch is worth applying. ;P

It seems like these are just mechanical "sendemail.foo is a default for
--foo" additions. Maybe it is better to simply make a note of that (or
mention it in the --foo section).

-Peff
